class AddFieldToTeacherProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :teacher_profiles, :request_info, :boolean, default: false
    add_column :teacher_profiles, :tour, :boolean, default: false
    add_column :teacher_profiles, :open_house, :boolean, default: false
  end
end
