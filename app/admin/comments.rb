ActiveAdmin.register Comment do
  menu priority: 4
  permit_params :commenter, :body, :user_id, :image_id
  preserve_default_filters!
  filter :image, collection: -> {
    Image.all.map { |img| [img.id] }
  }
end
