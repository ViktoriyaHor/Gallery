namespace :deploy do
  desc 'Upload config files'
  task upload_configs: ['deploy:check:linked_dirs'] do
    on roles(:all) do
      upload! 'config/database.yml', "#{deploy_to}/shared/config/database.yml"
      upload! 'config/master.key', "#{deploy_to}/shared/config/master.key"
    end
  end
end