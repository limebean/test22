class AddPhoneAndoccupationToParentProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :parent_profiles, :second_guardian_occupation, :string
    add_column :parent_profiles, :desired_schedule, :string
  end
end
