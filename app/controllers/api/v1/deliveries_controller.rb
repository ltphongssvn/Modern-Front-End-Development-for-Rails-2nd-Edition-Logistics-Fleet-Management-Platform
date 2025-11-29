# app/controllers/api/v1/deliveries_controller.rb
class Api::V1::DeliveriesController < Api::V1::BaseController
  before_action :set_delivery, only: [:show, :update]
  
  def index
    @deliveries = Delivery.includes(:route)
    render json: @deliveries
  end
  
  def show
    render json: @delivery
  end
  
  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      render json: @delivery, status: :created
    else
      render json: @delivery.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @delivery.update(delivery_params)
      ActionCable.server.broadcast("delivery_channel", @delivery)
      render json: @delivery
    else
      render json: @delivery.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end
  
  def delivery_params
    params.require(:delivery).permit(:tracking_number, :route_id, :status, :pickup_time, :delivery_time, :recipient_name, :recipient_signature, :package_details)
  end
end
