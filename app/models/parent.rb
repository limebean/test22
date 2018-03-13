class Parent < User
	has_one :teacher_profile, foreign_key: :parent_id, dependent: :destroy
end
