class AddProfileImageToTeacherProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :teacher_profiles, :profile_image, :string
  end
end
