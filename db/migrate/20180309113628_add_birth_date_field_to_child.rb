class AddBirthDateFieldToChild < ActiveRecord::Migration[5.1]
  def change
    add_column :children, :date_of_birth, :string
    add_column :children, :date, :string
  end
end
