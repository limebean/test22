class TeacherProfilesController < ApplicationController
  before_action :authenticate_user!
  def new
    @teacher_profile = TeacherProfile.new
    @teacher_profile.children.build
  end

  def create
    @teacher_profile = current_user.build_teacher_profile(permitted_teacher_params)
    if @teacher_profile.save
      flash[:notice] = 'Teacher successfully approved.'
      redirect_to teacher_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :new
    end
  end

  def edit
    @teacher_profile = Teacher.find(params[:id]).teacher_profile
  end

  # def update
  #   @teacher_profile = TeacherProfile.find(params[:])
  #   if @teacher_profile.save
  #     flash[:notice] = 'Teacher successfully approved.'
  #     redirect_to teacher_path
  #   else
  #     flash[:notice] = 'Something went wrong! Try again later.'
  #     render :new
  #   end
  # end

  private

    def permitted_teacher_params
      params.require(:teacher_profile).permit(
        :first_name, :last_name, :street_address,
        :apt_no, :city, :home_phone, :cell_phone,
        :date_of_birth, :language, :work,
        :legal_to_work, :apartment, :floor,
        :condo, :house, :basement_premises, :two_exit,
        :home_smoke, :pet, :vaccine, :goal, :age_range,
        :local_school, :school_name, :comments,
        children_attributes: [:id, :full_name, :age, :care_by, :_destroy]
      )
    end

end
