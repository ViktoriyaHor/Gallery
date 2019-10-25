ActiveAdmin.register Category do
  menu priority: 2
  filter :title
  permit_params :title, :user_id

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    column :id
    column :title
    column :created_at
    column :updated_at
    column :user
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :user
      f.input :title
    end
    f.actions
  end
end
