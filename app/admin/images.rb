ActiveAdmin.register Image do
  menu priority: 3
  remove_filter :comments, :likes
  permit_params :src, :category_id, :user_id

  index do
    selectable_column
    column :id
    column("Image") { |image| image_tag("#{image.src.url(:thumbnail)}")}
    resource_class.content_columns.each { |col| column col.name.to_sym }
    column :user
    column :category
    actions
  end
end
