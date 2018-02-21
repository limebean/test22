class TeachersController < ApplicationController

  before_action :set_teacher, only: [ :update_password, :set_password ]

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

  def set_password
    @teacher
  end

  private

    def set_teacher
      @teacher = Teacher.find_by(invitation_token: params[:token])
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
end
