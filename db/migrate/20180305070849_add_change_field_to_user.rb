class AddChangeFieldToUser < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :postal_code, true
    add_column :users, :last_name, :string
  end
end
