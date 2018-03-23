class AddAmountFieldToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :amount, :float, default: 0
  end
end
