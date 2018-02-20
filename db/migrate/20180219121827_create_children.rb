class CreateChildren < ActiveRecord::Migration[5.1]
  def change
    create_table :children do |t|
      t.belongs_to :teacher_profile, index: true, foreign_key: true
      t.string :full_name, null: false
      t.integer :age, null: false
      t.boolean :is_family, default: false
      t.boolean :is_private_placed, default: false
      t.timestamps
    end
  end
end
