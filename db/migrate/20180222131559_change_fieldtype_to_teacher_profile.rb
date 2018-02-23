class ChangeFieldtypeToTeacherProfile < ActiveRecord::Migration[5.1]
  def up
    remove_column :teacher_profiles, :apartment, :string
    remove_column :teacher_profiles, :house, :string
    add_column :teacher_profiles, :apartment, :boolean, default: false
    add_column :teacher_profiles, :house, :boolean, default: false
    change_column :teacher_profiles, :floor, :string, default: ''
  end

  def down
    remove_column :teacher_profiles, :apartment, :boolean
    remove_column :teacher_profiles, :house, :boolean
    add_column :teacher_profiles, :apartment, :string
    add_column :teacher_profiles, :house, :string
  end
end
