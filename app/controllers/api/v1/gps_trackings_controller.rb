# app/controllers/api/v1/gps_trackings_controller.rb
class Api::V1::GpsTrackingsController < Api::V1::BaseController
  def index
    @trackings = GpsTracking.includes(:vehicle).order(timestamp: :desc).limit(100)
    render json: @trackings.to_json(include: :vehicle)
  end
  
  def create
    @tracking = GpsTracking.new(tracking_params)
    if @tracking.save
      ActionCable.server.broadcast("gps_channel_#{@tracking.vehicle_id}", @tracking)
      render json: @tracking, status: :created
    else
      render json: @tracking.errors, status: :unprocessable_entity
    end
  end
  
  def latest
    vehicle_id = params[:vehicle_id]
    @tracking = GpsTracking.where(vehicle_id: vehicle_id).order(timestamp: :desc).first
    render json: @tracking || {}
  end
  
  private
  
  def tracking_params
    params.require(:gps_tracking).permit(:vehicle_id, :latitude, :longitude, :speed, :heading, :timestamp)
  end
end
