class ParentsController < ApplicationController
  layout :set_layout
  before_action :ensure_parent, only: :dashboard

  def check_email_availability
    @user = User.find_by_email(params[:user][:email])
    respond_to do |format|
        format.json { render :json => !@user }
    end
  end

  def dashboard
  end

  private
    def set_layout
      case action_name
      when 'dashboard'
        'admin'
      else
        'application'
      end
    end

    def ensure_parent
      unless current_user && current_user.parent?
        redirect_to parents_dashboard_path
      end
    end

end
