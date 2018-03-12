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

end
