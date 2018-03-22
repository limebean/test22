class Enrollment < ApplicationRecord
  after_create :notify_teacher_parent_for_new_enroll

  def notify_teacher_parent_for_new_enroll
    @teacher = Teacher.find(self.teacher_id)
    @parent = Child.find(child_id).parent
    [teacher.email, parent.email].each do | email|
        UserMailer.notify_teacher_parent_for_new_enroll(self, email).deliver_now
    end
  end

end
