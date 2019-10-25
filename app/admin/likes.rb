ActiveAdmin.register Like do
  menu priority: 5
  actions :all, except: [:update, :edit]
  preserve_default_filters!
  filter :image, collection: -> {
    Image.all.map { |img| [img.id] }
  }
  permit_params :image_id, :user_id
end
