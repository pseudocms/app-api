class AddBlessedToOAuthApplications < ActiveRecord::Migration
  def change
    add_column :oauth_applications, :blessed, :boolean, :default => false, :null => false
  end
end
