class Availability < ApplicationRecord
  serialize :recurrence, Montrose::Recurrence
  belongs_to :teacher
end
