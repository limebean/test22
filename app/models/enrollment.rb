class Enrollment < ApplicationRecord
	belongs_to :child
	belongs_to :teacher
	after_create :notify_teacher_parent_for_new_enroll
	def notify_teacher_parent_for_new_enroll
	    teacher = Teacher.find(teacher_id)
	    parent = Child.find(child_id).parent
	    UserMailer.notify_teacher_parent_for_new_enroll(self, teacher).deliver_now
	    UserMailer.notify_teacher_parent_for_new_enroll(self, parent).deliver_now
	end
end
