class TeacherProfile < ApplicationRecord
  belongs_to :user
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true
end
