class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code])
    end

    def ensure_is_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorised to access this area.'
      end
    end
end
