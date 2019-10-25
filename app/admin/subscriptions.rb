ActiveAdmin.register Subscription do
  menu priority: 6
  actions :all, except: [:update, :edit]
  preserve_default_filters!
  filter :image, collection: -> {
    Image.all.map { |img| [img.id] }
  }
  permit_params :category_id, :user_id
end
