class AddTransactionFieldInTeacherProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :teacher_profiles, :transaction_fee, :float
  end
end
