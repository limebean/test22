class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.belongs_to :teacher, index: true
      t.integer :child_time
      t.float :two_days_price
      t.float :three_days_price
      t.float :five_days_price
      t.timestamps
    end
  end
end
