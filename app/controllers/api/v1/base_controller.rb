# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  private
  
  def not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
