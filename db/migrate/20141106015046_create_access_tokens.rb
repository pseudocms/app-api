class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.references :application,  null: false,  index: true
      t.references :user,         null: false,  index: true
      t.string     :token,        null: false
      t.datetime   :created_at,   null: false
      t.integer    :expires_in,   default: 0
      t.datetime   :revoked_at
    end

    add_index :access_tokens, :token, unique: true
  end
end
