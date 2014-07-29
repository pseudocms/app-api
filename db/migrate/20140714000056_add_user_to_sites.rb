class AddUserToSites < ActiveRecord::Migration
  def change
    add_column :sites, :user_id, :integer, null: false
  end
end
