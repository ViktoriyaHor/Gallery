ActiveAdmin.register Comment do
  menu priority: 4
  permit_params :commenter, :body, :user_id, :image_id
  preserve_default_filters!
  filter :image, collection: -> {
    Image.all.map { |img| [img.id] }
  }
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
