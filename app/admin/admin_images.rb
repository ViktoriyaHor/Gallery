ActiveAdmin.register AdminImage do
  menu priority: 11
  config.comments = false
  config.filters = false
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
    def show_add
      render partial: 'form'
    end
    def add
      puts category_id = params[:images][:category_id]
      puts src = AdminImage.find(params[:id]).src
      puts user_id = User.first.id
      Image.create(:remote_src_url => src, :category_id => category_id, user_id: user_id)
      redirect_to admin_images_path
    end
  end

  index do
    selectable_column
    column :id
    column("Image") { |image| image_tag("#{image.src}")}
    column :src
    column :created_at
    column { |image| link_to 'Upload', show_add_admin_admin_image_path(image)}
    actions
  end
end
