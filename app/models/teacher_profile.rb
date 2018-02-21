class TeacherProfile < ApplicationRecord
  belongs_to :user
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true
  OPTION_WITH_NA = ['Yes', 'No', 'N/A']
  enum legal_to_work: OPTION_WITH_NA
  enum home_smoke: OPTION_WITH_NA
  enum vaccine: OPTION_WITH_NA
end