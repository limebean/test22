class AddLatitudeAndLongitudeToTeacherProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :teacher_profiles, :latitude, :float
    add_column :teacher_profiles, :longitude, :float
  end
end
