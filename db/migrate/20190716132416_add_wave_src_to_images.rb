class AddWaveSrcToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :wave_src, :string
  end
end
