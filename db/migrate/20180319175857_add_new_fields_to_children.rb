class AddNewFieldsToChildren < ActiveRecord::Migration[5.1]
  def change
    add_column :children, :gender, :string
    add_column :children, :allergies, :string
    add_column :children, :medication, :string
    add_column :children, :medical_condition, :string
  end
end
