class Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :require_no_authentication, only: [:new, :create]
    
    def create
        super do |user|
            user.name = sign_up_params[:name]
            user.save
        end
    end

    # def sign_up_params
    #     params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # end      
 end
  