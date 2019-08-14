class CreateLoggingUserActions < ActiveRecord::Migration[5.2]
  def change
    create_table :logging_user_actions do |t|
      t.references :user, foreign_key: true
      t.references :action, foreign_key: true
      t.string :action_path

      t.timestamps
    end
  end
end
