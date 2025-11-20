class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :vin
      t.string :make
      t.string :model
      t.integer :year
      t.string :vehicle_type
      t.string :status
      t.jsonb :current_location
      t.decimal :fuel_level
      t.integer :mileage

      t.timestamps
    end
    add_index :vehicles, :license_plate, unique: true
    add_index :vehicles, :vin, unique: true
  end
end
