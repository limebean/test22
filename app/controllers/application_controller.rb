class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def after_sign_in_path_for(_resource)
      binding.pry
      if current_user.admin?
         admin_teachers_path
      elsif current_user.teacher?
        teacher_profile_path(current_user.teacher_profile)
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code])
    end

    def ensure_is_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorised to access this area.'
      end
    end
end
