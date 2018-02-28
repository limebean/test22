class TeachersController < ApplicationController
  layout :set_layout
  before_action :authenticate_user!, except: [:show, :new, :create, :set_password, :update_password]
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
      redirect_to partner_path, alert: "Something went wrong! Please try again."
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

  def availability
  end

  def set_availability
    calander_events = JSON.parse(params[:calander_events])
    if calander_events.present?
      current_user.availabilities.destroy_all
      calander_events.each do |ce|
        @availability = current_user.availabilities.new(day_index: ce["week_day"], start_time: ce["hour_from"], end_time: ce["hour_to"])
        if @availability.save
          flash[:notice] = 'Teacher availability successfully created.'
        else
          flash[:notice] = 'Something went wrong! Try again later.'
        end
      end
    end
    redirect_to availability_teacher_path
  end

  def get_availability
    get_availabilities = current_user.availabilities
    availabilities = get_availabilities.map do |availabilitly|
      {
        day_of_week: availabilitly.day_index,
        start_hour: availabilitly.start_time.strftime("%H:%M:%S"),
        end_hour: availabilitly.end_time.strftime("%H:%M:%S")
      }
    end
    render json: availabilities
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
        :telephone_no,
        :postal_code,
        :password
      )
    end

    def set_layout
      case action_name
      when 'dashboard', 'availability'
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
