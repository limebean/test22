class Parent < User
  has_many :tour_requests, dependent: :destroy
  has_one :teacher_profile, foreign_key: :parent_id, dependent: :destroy
end
