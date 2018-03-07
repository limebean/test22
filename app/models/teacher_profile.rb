class TeacherProfile < ApplicationRecord
  belongs_to :teacher
  has_many :children,  inverse_of: :teacher_profile, dependent: :destroy
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

  validates :first_name, :last_name, :street_address, :apt_no, :city, :home_phone, :cell_phone, :date_of_birth, :language, :work, :legal_to_work, :vaccine, :goal, :age_range, :school_name, :comments, presence: true
  mount_uploader :profile_image, ImageUploader
 

  OPTION_WITH_NA =  { 0=> 'Yes', 1=> 'No', 2=> 'N/A'}
  geocoded_by :postal_code
  after_validation :geocode,  if: ->(obj){ obj.postal_code.present? and obj.postal_code_changed? }

end

