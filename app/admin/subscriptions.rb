ActiveAdmin.register Subscription do
  menu priority: 6
  actions :all, except: [:update, :edit]
  preserve_default_filters!
  filter :image, collection: -> {
    Image.all.map { |img| [img.id] }
  }
  permit_params :category_id, :user_id
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
