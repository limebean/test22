class TeachersController < ApplicationController
  before_action :set_teacher, only: %i(update_password new_password)
  def new
    @teacher = Teacher.new
  end

  def create
    teacher = Teacher.new(permitted_teacher_params)
    if teacher.save
      teacher.invitation_token
      redirect_to root_path, notice: "Thanks for register, Please open email for reset passowrd and complete registration"
    else
      render :new, alert: "Teacher was not successfully created."
    end
  end

  def update_password
    binding.pry
    if @teacher.update(permitted_teacher_password_params)
      bypass_sign_in(@teacher)
      redirect_to  new_teacher_profile_path, notice: 'Password successfully updated.'
    else
      redirect_to root_path, alert: 'Password cannot updated.'
    end
  end

  def new_password
    @teacher
  end

  def approve
    teacher = Teacher.find(params[:id])
    if teacher.present?
      teacher.update_attributes(is_approve: true)
      UserMailer.teacher_invitaion_email(teacher).deliver_now
      redirect_to admin_teachers_path, notice: 'Teacher successfully approved.'
    else
      redirect_to root_path, notice: 'Teacher not found.'
    end

  end

  private

    def set_teacher
      @teacher = Teacher.find_by(invitation_token: params[:id])
    end

    def permitted_teacher_password_params
      params.require(:teacher).permit(
        :password,
        :password_confirmation
      )
    end

    def permitted_teacher_params
      generated_password = Devise.friendly_token.first(8)
      params[:teacher][:password] = generated_password
      params.require(:teacher).permit(
        :name,
        :email,
        :postal_code,
        :password
      )
    end
end
