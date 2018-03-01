class Teacher < User

  has_one :teacher_profile, foreign_key: :teacher_id, dependent: :destroy
  has_many :availabilities, dependent: :destroy

  delegate :first_name, :last_name, :street_address, :date_of_birth, to: :teacher_profile, allow_nil: true

  after_create :notify_admin_for_new_application

  def notify_admin_for_new_application
    UserMailer.notify_admin_for_new_application(self).deliver_now
  end

end
