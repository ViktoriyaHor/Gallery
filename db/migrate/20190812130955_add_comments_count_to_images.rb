class AddCommentsCountToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :comments_count, :integer, null: false, default: 0
  end
end
