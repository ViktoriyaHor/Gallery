namespace :app do
  desc "migrate images"
  task :migrate_images => :environment do
    cats = Dir.entries("app/assets/images").reject {|f| File.directory?(f) || f.include?('.')}
    cats.each do |cat|
      Category.find_or_create_by(title:"#{cat}", slug:"#{cat}", user_id: 1)
      imgs = Dir.entries("app/assets/images/#{cat}").reject {|f| File.directory?(f)}
      id = Category.find_by(title:"#{cat}").id
      imgs.each do |img|
        Image.create(:src => open("/home/developer/gallery/app/assets/images/#{cat}/#{img}"), :category_id => id)
      end
    end
  end
end