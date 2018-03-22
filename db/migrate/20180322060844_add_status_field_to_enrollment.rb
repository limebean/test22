class AddStatusFieldToEnrollment < ActiveRecord::Migration[5.1]
  def change
    add_column :enrollments, :status, :boolean, default: false
  end
end
