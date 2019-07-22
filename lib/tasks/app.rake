# namespace :app do
#   desc "migrate images"
#   task :migrate_images => :environment do
#     cats = Dir.entries("app/assets/images").reject {|f| File.directory?(f) || f.include?('.')}
#     cats.each do |cat|
#       Category.find_or_create_by(title:"#{cat}", slug:"#{cat}")
#       imgs = Dir.entries("app/assets/images/#{cat}").reject {|f| File.directory?(f)}
#       id = Category.find_by(title:"#{cat}").id
#       imgs.each do |img|
#         Image.find_or_create_by(src: "#{cat}/#{img}", category_id: id)
#       end
#     end
#   end
# end

namespace :app do
  desc "migrate images"
  task :migrate_images => :environment do
    cats = Dir.entries("app/assets/images").reject {|f| File.directory?(f) || f.include?('.')}
    cats.each do |cat|
      Category.find_or_create_by(title:"#{cat}", slug:"#{cat}")
      imgs = Dir.entries("app/assets/images/#{cat}").reject {|f| File.directory?(f)}
      id = Category.find_by(title:"#{cat}").id
      imgs.each do |img|
        Image.create(:src => '11', :category_id => id, :wave_src => open("/home/developer/gallery/app/assets/images/#{cat}/#{img}"))
        # p Image.new(:wave_src => open("app/assets/images/#{cat}/#{img}"))

        # Image.find_or_create_by(src: "#{cat}/#{img}", category_id: id,
        #                         wave_src: Pathname.new("#{RAILS_ROOT}/assets/images/cars/classic-car-76423_1920.jpg").open )
        # Image.save!
      end
    end
  end
end