class AddPostalCodeFieldInTeacherProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :teacher_profiles, :postal_code, :string
  end
end
