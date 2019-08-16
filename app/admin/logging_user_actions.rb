ActiveAdmin.register LoggingUserAction do
  menu priority: 9
  actions :all, except: [:update, :edit]
  preserve_default_filters!
  filter :action, collection: -> {
    Action.all.map { |act| act.action_type}
  }

  index do
    selectable_column
    column :id
    column :user
    column("Action") { |act| Action.find(act.action_id).action_type}
    resource_class.content_columns.each { |col| column col.name.to_sym }
    actions
  end
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
