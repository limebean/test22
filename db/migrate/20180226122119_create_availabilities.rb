class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.belongs_to :teacher, index: true
      t.integer :day_index
      t.time :start_time
      t.time :end_time
      t.timestamps
    end
  end
end
