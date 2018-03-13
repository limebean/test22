class Parent < User
  has_many :tour_requests, dependent: :destroy
end
