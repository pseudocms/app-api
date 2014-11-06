class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string  :name,           null: false
      t.string  :client_id,      null: false
      t.string  :client_secret,  null: false
      t.boolean :blessed,        default: false

      t.timestamps null: false
    end

    add_index :applications,  :name,       unique: true
    add_index :applications,  :client_id,  unique: true
  end
end
