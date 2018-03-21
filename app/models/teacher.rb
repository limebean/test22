class Teacher < User
  has_one :teacher_profile, foreign_key: :teacher_id, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :prices,  dependent: :destroy
  has_many :tour_requests, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :children
  delegate :first_name, :last_name, :street_address, :date_of_birth, to: :teacher_profile, allow_nil: true

  after_create :notify_admin_for_new_application
  # after_create :notify_support_and_user
  def notify_admin_for_new_application
    ['self.email', 'support@dreamschools.co', 'admin@dreamschool.com'].each do |email|
      UserMailer.notify_admin_for_new_application(self, email).deliver_now
    end
    #UserMailer.notify_admin_for_new_application(self).deliver_now
  end

  # def notify_support_and_user
  #   ['self.email', 'support@dreamschools.co'].each |email|
  #     UserMailer.notify_support_and_user(email).deliver_now
  #   end
  # end

end
