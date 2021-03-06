class ParentProfile < ApplicationRecord
  belongs_to :parent
  after_create :notify_support_for_family_profile

  before_save do
    self.weekly_schedule.gsub!(/[\[\]\"]/, "") if attribute_present?("weekly_schedule")
    self.past_child_care.gsub!(/[\[\]\"]/, "") if attribute_present?("past_child_care")
    self.factor_to_enroll.gsub!(/[\[\]\"]/, "") if attribute_present?("factor_to_enroll")
    self.child_accomodation_needs.gsub!(/[\[\]\"]/, "") if attribute_present?("child_accomodation_needs")
  end

  def notify_support_for_family_profile
    UserMailer.notify_support_for_family_profile(self)
  end

end
