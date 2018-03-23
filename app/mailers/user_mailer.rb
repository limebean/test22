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

  def interest_for_open_house(user, parent = nil)
    @user = user
    @parent = parent
    mail(to: user.email, subject: 'Interest for open house')
  end

  def notify_teacher_parent_for_new_enroll(enroll, user)
    @enroll = enroll
    @user = user
    mail(to: @user.email, subject: 'We have received your application')
  end

  def make_payment_link(enroll)
    @enroll = enroll
    @teacher = enroll.teacher
    @child= enroll.child
    @parent = @child.parent
    mail(to: @parent.email, subject: 'We have received your application')
  end

  def support_mail(name, email, subject, message)
    @name = name
    @email = email
    @subject = subject
    @message = message
    mail(to: 'support@dreamschools.co', subject: 'contact us')
  end

end
