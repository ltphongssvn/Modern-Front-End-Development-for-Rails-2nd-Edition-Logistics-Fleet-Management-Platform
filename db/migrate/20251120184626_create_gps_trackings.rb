class CreateGpsTrackings < ActiveRecord::Migration[8.0]
  def change
    create_table :gps_trackings do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :speed
      t.integer :heading
      t.datetime :timestamp

      t.timestamps
    end
  end
end
