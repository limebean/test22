class ChildrenController < ApplicationController

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(permitted_teacher_password_params)
    if @child.save
      @child.invitation_token
      redirect_to root_path, notice: "Thanks for register, Please open email for reset passowrd and complete registration"
    else
      redirect_to partner_path, alert: "Something went wrong! Please try again."
    end
  end

  def abcd

  end

  private

  def permitted_teacher_password_params
    params.require(:child).permit(
      :teacher_profile_id,
      :full_name,
      :age,
      :care_by,
      :date_of_birth,
      :user_id,
      :place_of_birth
    )
  end
end
