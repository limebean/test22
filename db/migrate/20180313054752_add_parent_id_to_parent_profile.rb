class AddParentIdToParentProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :parent_profiles, :parent_id, :integer
  end
end
