class ChildrenController < ApplicationController

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(permitted_children_params)
    if @child.save
      @child.invitation_token
      redirect_to child_path(@child), notice: "success"
    else
      redirect_to partner_path, alert: "Something went wrong! Please try again."
    end
  end

  def show
  end

  private

  def permitted_children_params
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
