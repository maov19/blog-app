class Users::SessionsController < Devise::SessionsController
    skip_before_action :require_no_authentication, only: [:new, :create]
    
    def new
      super
    end
  
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

    def destroy
      super
    end
  end
  