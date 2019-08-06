class AddCachedFailedAttemptsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cached_failed_attempts, :integer, default: 0, null: false
  end
end
