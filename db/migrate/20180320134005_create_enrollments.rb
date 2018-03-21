class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.belongs_to :child, index: true
      t.belongs_to :teacher, index: true
      t.string :start_date
      t.string :weekdays_and_time
      t.string :other_comments

      t.timestamps
    end
  end
end
