class Parent < User
	has_many :children, dependent: :destroy
end
