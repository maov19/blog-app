class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
  
    private
  
    def authenticate_api_request
      auth_token = request.headers['x-api-key']
      @current_user = User.find_by(auth_token:)
  
      return if @current_user
  
      render json: { error: 'Invalid authentication token' }, status: :unauthorized
    end
  end