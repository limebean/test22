class CreateChildren < ActiveRecord::Migration[5.1]
  def change
    create_table :children do |t|
      t.belongs_to :teacher_profile, index: true, foreign_key: true
      t.string :full_name, null: false
      t.integer :age, null: false
      t.integer :care_by, null: false
      t.timestamps
    end
  end
end
