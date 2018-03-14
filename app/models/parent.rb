class Parent < User
	has_one :parent_profile, foreign_key: :parent_id, dependent: :destroy
end
