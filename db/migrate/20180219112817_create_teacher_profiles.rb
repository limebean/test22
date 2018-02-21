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
      t.boolean :condo

      t.string :house
      t.boolean :basement_premises
      t.boolean :two_exit

      t.boolean :home_smoke
      t.boolean :pet
      t.integer :vaccine, null: false

      t.string :goal
      t.string :age_range, null: false
      t.boolean :local_school, null: false
      t.string :school_name, null: false
      t.text :comments, null: false

      #t.string :hear_of_site
      #t.string :work

      t.timestamps
    end
  end
end