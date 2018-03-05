class TeacherProfilesController < ApplicationController
  layout :set_layout
  before_action :authenticate_user!
  before_action :set_teacher_profile, only: %i[edit show update]

  def new    
    @teacher_profile = current_user.build_teacher_profile
    @teacher_profile.children.build
  end

  def create    
    @teacher_profile = current_user.build_teacher_profile(permitted_teacher_params)
    if @teacher_profile.save
      flash[:notice] = 'Teacher profile successfully created.'
      redirect_to dashboard_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :new
    end
  end

  def edit; end

  def update
    if @teacher_profile.present? && @teacher_profile.update_attributes(permitted_teacher_params)
      flash[:notice] = 'Teacher profile successfully updated.'
      redirect_to dashboard_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :edit
    end
  end

  def show;  end

  private

    def set_teacher_profile
      @teacher_profile = TeacherProfile.find(params[:id])
    end

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

    def set_layout
      case action_name
      when 'edit'
        'admin'
      else
        'application'
      end
    end

end
