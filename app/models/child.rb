class Child < ApplicationRecord
  belongs_to :teacher_profile
  CARE_BY = ['Family', 'Privately-Placed drop-down menu']
  enum care_by: CARE_BY
end
