class CreateParentProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :parent_profiles do |t|
      t.string :guardian_name
      t.string :guardian_email
      t.string :guardian_occupation
      t.string :guardian_phone
      t.string :second_guardian_name
      t.string :second_guardian_email
      t.string :second_guardian_phone
      t.string :child_name
      t.date :child_date_of_birth
      t.date :start_of_care
      t.string :end_of_care
      t.string :weekly_schedule
      t.string :past_child_care
      t.string :child_eat_habits
      t.string :child_sleep_habits
      t.string :describe_child
      t.string :child_temperament
      t.string :behavioral_situation
      t.string :factor_to_enroll
      t.string :parent_needs
      t.string :child_accomodation_needs
      t.string :recent_reaction
      t.string :school_meeting_concern
      t.string :hear_about_us

      t.timestamps
    end
  end
end
