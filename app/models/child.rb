class Child < ApplicationRecord
  belongs_to :teacher_profile
  belongs_to :parent
  validates :full_name, :age, :care_by, presence: true

  CARE_BY = ['Family', 'Privately-Placed']
  enum care_by: CARE_BY
end
