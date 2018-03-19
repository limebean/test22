class NullFalseRemoveFromChildren < ActiveRecord::Migration[5.1]
  def change
  	change_column :children, :age, :integer, :null => true
  	change_column :children, :care_by, :integer, :null => true
  end
end
