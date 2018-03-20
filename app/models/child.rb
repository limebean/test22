class Child < ApplicationRecord
  belongs_to :teacher_profile
  belongs_to :parent
  validates :full_name, presence: true

  CARE_BY = ['Family', 'Privately-Placed']
  enum care_by: CARE_BY
end
