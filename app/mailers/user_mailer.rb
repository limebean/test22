class UserMailer < ApplicationMailer
  default from: 'no-reply@web_ds.com'

  def notify_admin_for_new_application(teacher)
    @teacher = teacher
    mail(to: 'admin@dreamschool.com', subject: 'Approve the teacher profile')
  end

  def teacher_invitaion_email(teacher)
    @teacher = teacher
    mail(to: @teacher.email, subject: 'Welcome to the wonder school')
  end

  def notify_parent_for_tour_booking(tour_request, user)
  	@tour_request = tour_request
    @user = user
    mail(to: @user.email, subject: 'Your tour booking information')
  end

end
