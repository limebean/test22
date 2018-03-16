class ParentProfilesController < ApplicationController

	def new
    @parent_profile = ParentProfile.new
  end

  def create
    @parent_profile = current_user.build_parent_profile(permitted_parent_params)
    if @parent_profile.save
      flash[:notice] = 'Parent profile successfully created.'
      redirect_to parent_profile_path(@parent_profile)
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :new
    end
  end

  def edit
     
  end

  def update
    if @parent_profile.present? && @parent_profile.update_attributes(permitted_parent_params)
      flash[:notice] = 'Teacher profile successfully updated.'
      redirect_to dashboard_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :edit
    end
  end

  def show
    @parent_profile= ParentProfile.find(params[:id])
  end

  private

  	def set_teacher_profile
      @parent_profile = ParentProfile.find(params[:id])
    end

    def permitted_parent_params
      params.require(:parent_profile).permit(
         :guardian_name,:guardian_email,:guardian_occupation,
         :guardian_phone,:second_guardian_name,:second_guardian_email,
				 :second_guardian_phone,:child_name,:child_date_of_birth,:desired_schedule,
				 :start_of_care,:end_of_care,:child_eat_habits,:second_guardian_occupation,
				 :child_sleep_habits,:describe_child,:child_temperament,:behavioral_situation,
				 :recent_reaction,:school_meeting_concern,:hear_about_us, 
				 weekly_schedule: [], past_child_care:[],factor_to_enroll:[],child_accomodation_needs:[]
      )
    end
end
