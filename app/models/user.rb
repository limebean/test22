class User < ApplicationRecord

  has_many :tour_requests, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  ROLE = %w(Teacher Parent Admin)

  validates :name, presence: true
  has_secure_token :invitation_token
  validates :type, inclusion: { in: ROLE }

  ROLE.each do |method|
    define_method "#{method.downcase}?" do
      type == method
    end
  end

end
