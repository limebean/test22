class Price < ApplicationRecord
  belongs_to :teacher

  CHILD_TIME = { 'Daytime, Over 2 Years Old': 0, 'Daytime, Under 2 Years Old': 1, 'Nighttime, Over 2 Years Old': 2, 'Nighttime, Under 2 Years Old': 3 }

  enum child_time: CHILD_TIME

end