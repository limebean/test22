class RemoveDateFromChild < ActiveRecord::Migration[5.1]
  def change
  	remove_column :children, :date
  end
end
