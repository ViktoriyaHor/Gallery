# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "Gallery"
set :repo_url, "git@github.com:ViktoriyaHor/Gallery.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/gallery"

set :rvm1_ruby_version, '2.6.3'

# set :rvm1_map_bins,   -> { %w{rake gem bundle ruby} }
# set :bundle_roles, :all                                         # this is default
# set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
# set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
# set :bundle_gemfile, -> { release_path.join('Gemfile') }      # default: nil
# set :bundle_path, -> { shared_path.join('bundle') }             # this is default. set it to nil for skipping the --path flag.
# set :bundle_without, %w{development test}.join(' ')             # this is default
# set :bundle_flags, '--deployment --quiet'                       # this is default
# set :bundle_env_variables, {}                                   # this is default
# set :bundle_clean_options, ""                                   # this is default. Use "--dry-run" if you just want to know what gems would be deleted, without actually deleting them
# set :bundle_check_before_install, true

# set :rvm_path, "$HOME/.rvm"

# set :rvm1_type, :system
# set :rbenv_type, :user # or :system, depends on your rbenv setup
# set :rbenv_ruby, '2.6.3'
# set :rbenv_path, '/home/ubuntu/.rbenv'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, *%w(
  config/database.yml
  config/master.key
)

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, *%w(
  log
  public/system
  public/uploads
  tmp/cache
  tmp/pids
  tmp/sockets
  tmp/letter_opener
  .bundle
)
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 1

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
# Puma config
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
# set :puma_init_active_record, true
# set :puma_preload_app, true
#
# before 'deploy', 'rvm1:install:rvm'
# before 'deploy', 'rvm1:install:ruby'  # install/update Ruby
# before 'deploy', 'bundler:install'
# #
# task :execute, :command do |_task, args|
#   on roles :app do
#     within current_path do
#       # cap production "execute[update:role['developer']]"
#       execute :bundle, "exec rake #{args[:command]} RAILS_ENV=production"
#     end
#   end
# end
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end
namespace :deploy do
desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
  # task :create_symlink do
  #   on roles :app do
  #     within current_path do
  #       p '****************** CREATE SYMLINK ******************'
  #       execute 'ln -s /home/production/www/employees/shared/config/.env.production /home/production/www/employees/current'
  #     end
  #   end
  # end

  # task :restart do
  #   on roles :app do
  #     within current_path do
  #       p '****************** REBOOTING SERVER ******************'
  #       execute "kill -SIGKILL `cat /home/production/www/employees/shared/tmp/pids/server.pid` && rm /home/production/www/employees/shared/tmp/pids/server.pid"
  #       execute :bundle, "exec rails s -e production -d -p 3005"
  #     end
  #   end
  # end

  # task :start do
  #   on roles :app do
  #     within current_path do
  #       p '****************** STARTING SERVER ******************'
  #       execute :bundle, "exec rails s -e production -d -p 3005"
  #     end
  #   end
  # end
  #
  # task :stop do
  #   on roles :app do
  #     within current_path do
  #       p '****************** STOPPING SERVER ******************'
  #       execute "kill -SIGKILL `cat /home/production/www/employees/shared/tmp/pids/server.pid` && rm /home/production/www/employees/shared/tmp/pids/server.pid"
  #     end
  #   end
  # end

#   task :seed do
#     on roles :app do
#       within current_path do
#         execute :rake, "db:seed"
#       end
#     end
#   end
# end
# after 'deploy:finished', 'deploy:create_symlink'
# after 'deploy:finished', 'deploy:start'