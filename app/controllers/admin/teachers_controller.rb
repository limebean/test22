class Admin::TeachersController < Admin::AdminBaseController

  def index
    @teachers = Teacher.all
  end

  def edit
    @teacher_profile = TeacherProfile.find(params[:id])
  end

  def update
    @teacher_profile = TeacherProfile.find(params[:id])
    if @teacher_profile.present? && @teacher_profile.update_attributes(permitted_teacher_params)
      flash[:notice] = 'Teacher profile successfully updated.'
      redirect_to admin_teachers_path
    else
      flash[:notice] = 'Something went wrong! Try again later.'
      render :new
    end
  end

  def approve
    teacher = Teacher.find(params[:id])
    if teacher.present? && teacher.update_attribute(:approve, true)
      UserMailer.teacher_invitaion_email(teacher).deliver_now
      flash[:notice] = 'Teacher successfully approved.'
    else
      flash[:notice] = 'Something went wrong! Try again later.'
    end
    redirect_to admin_teachers_path
  end

  def reject
    teacher = Teacher.find(params[:id])
    if teacher.present? && teacher.update_attribute(:approve, false)
      flash[:notice] = 'Teacher successfully rejected.'
    else
      flash[:notice] = 'Something went wrong! Try again later.'
    end
    redirect_to admin_teachers_path
  end

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
