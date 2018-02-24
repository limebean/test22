class TeachersController < ApplicationController
  layout :set_layout
  before_action :authenticate_user!, except: :show
  before_action :set_teacher, only: [ :update_password, :set_password ]
  before_action :ensure_teacher, only: :dashboard

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(permitted_teacher_params)
    if @teacher.save
      @teacher.invitation_token
      redirect_to root_path, notice: "Thanks for register, Please open email for reset passowrd and complete registration"
    else
      render :new, alert: "Something went wrong! Please try again."
    end
  end

  def show
  end

  def update_password
    if @teacher.update(permitted_teacher_password_params)
      bypass_sign_in(@teacher)
      redirect_to new_teacher_profile_path, notice: 'Your password has been set successfully. You can now update your profile.'
    else
      redirect_to root_path, alert: 'Password could not be set.'
    end
  end

  def dashboard
    unless current_user.teacher_profile.presence
      redirect_to new_teacher_profile_path, notice: 'You need to update your profile!'
    end
  end

  def set_password
    @teacher
  end

  private

    def set_teacher
      @teacher ||= Teacher.find_by(invitation_token: params[:token])
    end

    def permitted_teacher_password_params
      params.require(:teacher).permit(
        :password,
        :password_confirmation
      )
    end

    def permitted_teacher_params
      params[:teacher][:password] = Devise.friendly_token.first(8)
      params.require(:teacher).permit(
        :name,
        :email,
        :postal_code,
        :password
      )
    end

    def set_layout
      case action_name
      when 'dashboard'
        'admin'
      else
        'application'
      end
    end

    def ensure_teacher
      unless current_user && current_user.teacher?
        redirect_to admin_dashboard_path
      end
    end
end
