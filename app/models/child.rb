class Child < ApplicationRecord
  belongs_to :parent
  belongs_to :teacher_profile
  validates :full_name, presence: true

  CARE_BY = ['Family', 'Privately-Placed']
  enum care_by: CARE_BY
end
