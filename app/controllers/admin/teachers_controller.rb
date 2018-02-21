class Admin::TeachersController < Admin::AdminBaseController

  def index
    @teachers = Teacher.all
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

end
