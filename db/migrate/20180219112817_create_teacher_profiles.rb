class CreateTeacherProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_profiles do |t|
      t.belongs_to :teacher, index: true
      t.string :first_name,  null: false
      t.string :last_name,   null: false
      t.text :street_address,null: false
      t.string :apt_no
      t.string :city,        null: false
      t.string :home_phone,  null: false
      t.string :cell_phone,  null: false
      t.date :date_of_birth
      t.string :language,    null: false
      t.string :work
      t.integer :legal_to_work, null: false

      t.string :apartment
      t.string :floor,       null: false
      t.boolean :is_condo,  null: false

      t.string :house
      t.boolean :is_basement, null: false
      t.boolean :is_two_exits, null: false

      t.integer :home_smoke, null: false
      t.boolean :is_pets
      t.integer :vaccine, null: false

      t.string :goal
      t.string :age_range, null: false
      t.boolean :is_local_school, null: false
      t.string :school_name
      t.text :comments

      #t.string :hear_of_site
      #t.string :work

      t.timestamps
    end
  end
end