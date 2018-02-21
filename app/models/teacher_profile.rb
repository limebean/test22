class TeacherProfile < ApplicationRecord
  belongs_to :teacher
  has_many :children,  inverse_of: :teacher_profile, dependent: :destroy
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

  validates :first_name, :last_name, :street_address, :apt_no, :city, :home_phone, :cell_phone, :date_of_birth, :language, :work, :legal_to_work, :apartment, :floor, :house, :vaccine, :goal, :age_range, :local_school, :school_name, :comments, presence: true
  OPTION_WITH_NA = ['Yes', 'No', 'N/A']

  # OPTION_WITH_NA =  {
  #     0 => "Yes",
  #     1 => "No",
  #     2 => "N/A",

  #   }
  enum legal_to_work: OPTION_WITH_NA
  # enum vaccine: STATUS_HASH

end