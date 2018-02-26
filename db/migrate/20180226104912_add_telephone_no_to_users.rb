class AddTelephoneNoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :telephone_no, :string
  end
end
