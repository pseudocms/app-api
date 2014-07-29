class SitesUsers < ActiveRecord::Migration
  def change
    create_table :sites_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :site
    end

    add_index :sites_users, [:user_id, :site_id], unique: true
    add_index :sites_users, :user_id
    add_index :sites_users, :site_id
  end
end
