class CreateTourRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_requests do |t|
      t.belongs_to :teacher, index: true
      t.date :tour_date
      t.time :tour_time
      t.string :phone
      t.timestamps
    end
  end
end
