desc "migrate images"
task :migrate_images do
  on roles(:app) do
    within "#{current_path}" do
      with rails_env: :production do
        execute :rake, "task:migrate_images"
      end
    end
  end
end