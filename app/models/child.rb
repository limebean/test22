class Child < ApplicationRecord
  belongs_to :parent,optional:true
  belongs_to :teacher_profile
  has_many :enrollments
  validates :full_name, presence: true

  CARE_BY = ['Family', 'Privately-Placed']
  enum care_by: CARE_BY
end
