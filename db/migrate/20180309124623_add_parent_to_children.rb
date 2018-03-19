class AddParentToChildren < ActiveRecord::Migration[5.1]
  def change
    add_reference :children, :user, foreign_key: true
  end
end
