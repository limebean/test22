class AddEnrollmentIdToPayment < ActiveRecord::Migration[5.1]
  def change
    add_reference :payments, :enrollment, foreign_key: true
  end
end
