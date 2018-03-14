class Price < ApplicationRecord
  belongs_to :teacher

  CHILD_TIME = { 'Full Day, 1-18 months': 0, 'Full Day, 18-30 months': 1, 'Full Day, 31-72 months': 2, 'Half Day, 1-18 months': 3, 'Half Day, 18-30 months': 4, 'Half Day, 31-72 months': 5, 'Nighttime, 1-18 months': 6, 'Nighttime, 18-30 months': 7, 'Nighttime, 31-72 months': 8 }

  enum child_time: CHILD_TIME

end