class AddStripeInfoFieldToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :expiry_date, :date
    add_column :users, :active, :boolean
  end
end
