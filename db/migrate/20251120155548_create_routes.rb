class CreateRoutes < ActiveRecord::Migration[8.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.jsonb :origin
      t.jsonb :destination
      t.jsonb :waypoints
      t.decimal :distance
      t.integer :estimated_duration
      t.string :status
      t.references :driver, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
