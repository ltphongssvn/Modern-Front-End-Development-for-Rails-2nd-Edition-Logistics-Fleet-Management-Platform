class CreateDrivers < ActiveRecord::Migration[8.0]
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.string :license_number
      t.string :phone
      t.string :email
      t.string :status
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
    add_index :drivers, :license_number, unique: true
    add_index :drivers, :email, unique: true
  end
end
