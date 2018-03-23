class AddParentToChildren < ActiveRecord::Migration[5.1]
  def change
    add_reference :children, :parent,index: true
  end
end
