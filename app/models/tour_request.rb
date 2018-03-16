class TourRequest < ApplicationRecord
  belongs_to :teacher
  belongs_to :user
  after_create :notify_parent_for_tour_booking

  def notify_parent_for_tour_booking
  	parent = User.find(self.user_id)
  	teacher = Teacher.find(self.teacher_id)
    UserMailer.notify_parent_for_tour_booking(self, parent).deliver_now
    UserMailer.notify_parent_for_tour_booking(self, teacher).deliver_now
  end

end
