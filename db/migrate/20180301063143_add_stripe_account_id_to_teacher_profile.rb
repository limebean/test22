class AddStripeAccountIdToTeacherProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :teacher_profiles, :stripe_account_id, :string
  end
end
