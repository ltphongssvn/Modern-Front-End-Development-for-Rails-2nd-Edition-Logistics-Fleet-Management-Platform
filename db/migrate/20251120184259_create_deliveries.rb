class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.string :tracking_number
      t.references :route, null: false, foreign_key: true
      t.string :status
      t.datetime :pickup_time
      t.datetime :delivery_time
      t.string :recipient_name
      t.text :recipient_signature
      t.jsonb :package_details

      t.timestamps
    end
    add_index :deliveries, :tracking_number, unique: true
  end
end
