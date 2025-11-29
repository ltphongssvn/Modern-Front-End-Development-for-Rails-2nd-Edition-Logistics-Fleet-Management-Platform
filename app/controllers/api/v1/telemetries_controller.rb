# app/controllers/api/v1/telemetries_controller.rb
class Api::V1::TelemetriesController < Api::V1::BaseController
  def index
    @telemetries = Telemetry.includes(:vehicle).order(timestamp: :desc).limit(50)
    render json: @telemetries.to_json(include: :vehicle)
  end
  
  def create
    @telemetry = Telemetry.new(telemetry_params)
    if @telemetry.save
      ActionCable.server.broadcast("telemetry_channel_#{@telemetry.vehicle_id}", @telemetry)
      render json: @telemetry, status: :created
    else
      render json: @telemetry.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def telemetry_params
    params.require(:telemetry).permit(:vehicle_id, :engine_temp, :oil_pressure, :battery_voltage, :tire_pressure, :diagnostic_codes, :timestamp)
  end
end
