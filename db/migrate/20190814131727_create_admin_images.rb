class CreateAdminImages < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_images do |t|
      t.string :src

      t.timestamps
    end
  end
end
