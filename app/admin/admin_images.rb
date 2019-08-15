ActiveAdmin.register AdminImage do
  config.comments = false
  # config.clear_action_items!

  actions :all, :except => [:show, :update, :edit]

  batch_action :upload do |ids|
    batch_action_collection.find(ids).each do |image|
      puts category_id = Category.first.id
      puts src = image.src
      puts user_id = User.first.id
      Image.create(:remote_src_url => src, :category_id => category_id, user_id: user_id)
    end
    redirect_to collection_path, alert: "The images have been upload."
  end

  member_action :show_add, :method=>:get do
  end
  member_action :add, :method=>:post do
  end

  controller do
    # def index
    #   # scraping_images("https://marvel.com.ru")
    # end
    # private_methods
    # def scraping_images(url)
    #   require 'upload_images'
    #   require 'open-uri'
    #   document = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    #   img = document.css("img")
    #   img.each do |link|
    #     AdminImage.create(:src => link.attributes["src"].value)
    #   end
    # end
    def show_add
      render partial: 'form'
    end
    def add
      # {"utf8"=>"✓", "authenticity_token"=>"qqs1tH3GZT9pQge6W7VKP4BFnZ/fvqTSD2T/GoLSh94l5Ku8gYbgtn8tjmKIGwzI34HeR9Yd4Frr5HZmxzqmbg==", "images"=>{"url"=>"1"}, "commit"=>"Get Images", "controller"=>"admin/admin_images", "action"=>"add", "id"=>"2174"}
      puts category_id = params[:category][:category_id]
      puts src = AdminImage.find(params[:id]).src
      puts user_id = User.first.id
      Image.create(:remote_src_url => src, :category_id => category_id, user_id: user_id)
      redirect_to admin_images_path

    end
  end

  index do
    selectable_column
    column("Image") { |image| image_tag("#{image.src}")}
    column :src
    column :created_at
    # column("Link") {link_to('Add', admin_images_path, method: post)}
    column { |image| link_to 'Upload', show_add_admin_admin_image_path(image)}
    actions
  end

  # action_item :add do
  #   link_to "Add", admin_admin_images_path, method: :get
  # end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
