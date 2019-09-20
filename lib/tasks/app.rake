namespace :app do
  desc "migrate images"
  task :migrate_images => :environment do
    user = User.create(email: "user@name.com", password: 'password', password_confirmation: 'password', :username => 'user')
    if Rails.env.production?
      user.confirm
    end
    user_id = user.id
    # user_id = User.first.id
    cats = Dir.entries("app/assets/images").reject {|f| File.directory?(f) || f.include?('.')}
    cats.each do |cat|
      Category.find_or_create_by(title:"#{cat}", slug:"#{cat}", user_id: user_id)
      imgs = Dir.entries("app/assets/images/#{cat}").reject {|f| File.directory?(f)}
      id = Category.find_by(title:"#{cat}").id
      imgs.each do |img|
        Image.create!(:src => open("#{Rails.root}/app/assets/images/#{cat}/#{img}"), :category_id => id, user_id: user_id)
      end
    end
  end
end