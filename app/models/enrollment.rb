class Enrollment < ApplicationRecord
  belongs_to :child
  belongs_to :teacher
  has_one :payment

  after_create :notify_teacher_parent_for_new_enroll

  def notify_teacher_parent_for_new_enroll
    UserMailer.notify_teacher_parent_for_new_enroll(self, teacher).deliver_later
    UserMailer.notify_teacher_parent_for_new_enroll(self, child.parent).deliver_later
  end

end
