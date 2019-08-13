class AddLikesCountToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :likes_count, :integer, null: false, default: 0
  end
end
