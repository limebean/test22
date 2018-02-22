class Admin::TeachersController < Admin::AdminBaseController

  def index
    @teachers = Teacher.all
  end

  def edit

  end

  def update

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
    binding.pry
    teacher = Teacher.find(params[:id])
    if teacher.present? && teacher.update_attribute(:approve, false)
      flash[:notice] = 'Teacher successfully rejected.'
    else
      flash[:notice] = 'Something went wrong! Try again later.'
    end
    redirect_to admin_teachers_path
  end

end
