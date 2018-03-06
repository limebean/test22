class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def after_sign_in_path_for(_resource)
      if current_user.admin?
        admin_dashboard_path
      elsif current_user.teacher?
        dashboard_path
      elsif current_user.parent?
        parents_dashboard_path
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name])
    end

    def ensure_is_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorised to access this area.'
      end
    end
end
