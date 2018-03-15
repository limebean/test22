class TourRequest < ApplicationRecord
  belongs_to :teacher
  belongs_to :user
end
