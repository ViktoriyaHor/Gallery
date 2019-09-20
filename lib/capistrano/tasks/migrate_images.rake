namespace :deploy do
  desc "migrate images"
  task :migrate_images do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "app:migrate_images"
        end
      end
    end
  end
end