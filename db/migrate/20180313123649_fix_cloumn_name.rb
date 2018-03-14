class FixCloumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :parent_profiles, :child_name, :parent_profile_child_name
    rename_column :parent_profiles, :child_date_of_birth, :parent_profile_child_date_of_birth
  end
end
