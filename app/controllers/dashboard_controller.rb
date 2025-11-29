# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @vehicles = Vehicle.all
    @routes = Route.includes(:driver, :vehicle)
    @active_deliveries = Delivery.where(status: 'in_progress')
  end
end
