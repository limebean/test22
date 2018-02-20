class Teacher < User
  has_one :teacher_profile, dependent: :destroy
  after_create :notify_admin

  def notify_admin
    UserMailer.notify_admin(self).deliver_now
  end

  # def invitation
  #   UserMailer.teacher_invitaion_email(self).deliver_now
  # end

  # def reset_password
  #   binding.pry
  # end

end
