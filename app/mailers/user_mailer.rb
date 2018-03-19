class UserMailer < ApplicationMailer
  default from: 'no-reply@web_ds.com'

  def notify_admin_for_new_application(teacher, email)
    @teacher = teacher
    @email = email
    mail(to: 'admin@dreamschool.com', subject: 'Approve the teacher profile')
    if(email.eql?('admin@dreamschool.com'))
      mail(to: email, subject: 'Approve the teacher profile')
    elsif(email.eql?('support@dreamschools.co'))
      mail(to: email, subject: 'User support mail')
    else
      mail(to: email, subject: 'Thank you for your interest')
    end

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

  def notify_support_for_family_profile(family_profile)
    @family_profile = family_profile
    mail(to: 'support@dreamschools.co', subject: 'Parent have completed family profile')
  end

end
