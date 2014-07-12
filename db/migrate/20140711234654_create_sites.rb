class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name, null: false, length: { max: 200 }
      t.string :description

      t.timestamps
    end

    add_index :sites, :name, unique: true
  end
end
