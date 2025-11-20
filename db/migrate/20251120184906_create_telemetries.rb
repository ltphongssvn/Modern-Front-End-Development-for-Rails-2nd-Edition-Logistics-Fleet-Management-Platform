class CreateTelemetries < ActiveRecord::Migration[8.0]
  def change
    create_table :telemetries do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.decimal :engine_temp
      t.decimal :oil_pressure
      t.decimal :battery_voltage
      t.jsonb :tire_pressure
      t.jsonb :diagnostic_codes
      t.datetime :timestamp

      t.timestamps
    end
  end
end
