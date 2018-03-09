class AddColumnInTeacherProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column  :teacher_profiles, :cover_photo, :string
  end
end
