# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "Gallery"
set :repo_url, "git@github.com:ViktoriyaHor/Gallery.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/gallery"

set :rvm1_ruby_version, '2.6.3'

set :rvm1_map_bins,   -> { %w{rake gem bundle ruby} }

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

namespace :deploy do

  task :restart do
    on roles :app do
      within current_path do
        p '****************** REBOOTING SERVER ******************'
        execute "kill -SIGKILL `cat /home/ubuntu/gallery/shared/tmp/pids/server.pid` && rm /home/ubuntu/gallery/shared/tmp/pids/server.pid"
        execute :bundle, "exec rails s -e production -d -p 3005"
      end
    end
  end

  task :start do
    on roles :app do
      within current_path do
        p '****************** STARTING SERVER ******************'
        execute :bundle, "exec rails s -e production -d -p 3005"
      end
    end
  end

  task :stop do
    on roles :app do
      within current_path do
        p '****************** STOPPING SERVER ******************'
        execute "kill -SIGKILL `cat /home/ubuntu/gallery/shared/tmp/pids/server.pid` && rm /home/ubuntu/gallery/shared/tmp/pids/server.pid"
      end
    end
  end
end

after 'deploy:finished', 'deploy:restart'