class Parent < User
  has_one :parent_profile, foreign_key: :parent_id, dependent: :destroy
  has_many :children, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :payments
end
