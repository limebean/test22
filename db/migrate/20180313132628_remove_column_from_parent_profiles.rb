class RemoveColumnFromParentProfiles < ActiveRecord::Migration[5.1]
  def change
  	remove_column :parent_profiles, :parent_needs, :string
  end
end
