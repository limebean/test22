class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.belongs_to :parent, index: true
      t.belongs_to :teacher, index: true
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
