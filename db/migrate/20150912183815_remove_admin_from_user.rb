class RemoveAdminFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :boolean, default: true
  end
end
