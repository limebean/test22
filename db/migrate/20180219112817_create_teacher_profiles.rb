class CreateTeacherProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_profiles do |t|
      t.belongs_to :teacher, index: true
      t.text :street_address
      t.string :apt
      t.string :hear_of_site
      t.string :home_phone
      t.string :cell
      t.string :work
      t.string :apartment
      t.string :house
      t.string :floor
      t.boolean :is_basement
      t.boolean :is_condo
      t.boolean :is_two_exits
      t.boolean :is_smoking
      t.boolean :is_pets
      t.boolean :is_vaccinations
      t.string :language
      t.boolean :is_ability_to_work
      t.boolean :is_legal_to_work
      t.string :age_range
      t.boolean :is_local_school
      t.string :school_name
      t.string :comments
      t.timestamps
    end
  end
end
