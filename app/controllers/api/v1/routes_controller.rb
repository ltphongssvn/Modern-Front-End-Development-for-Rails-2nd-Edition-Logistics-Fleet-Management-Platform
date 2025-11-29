# app/controllers/api/v1/routes_controller.rb
class Api::V1::RoutesController < Api::V1::BaseController
  before_action :set_route, only: [:show, :update, :destroy]
  
  def index
    @routes = Route.includes(:driver, :vehicle)
    render json: @routes.to_json(include: [:driver, :vehicle])
  end
  
  def show
    render json: @route.to_json(include: [:driver, :vehicle])
  end
  
  def create
    @route = Route.new(route_params)
    if @route.save
      render json: @route, status: :created
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @route.update(route_params)
      render json: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @route.destroy
    head :no_content
  end
  
  private
  
  def set_route
    @route = Route.find(params[:id])
  end
  
  def route_params
    params.require(:route).permit(:name, :origin, :destination, :waypoints, :distance, :estimated_duration, :status, :driver_id, :vehicle_id)
  end
end
