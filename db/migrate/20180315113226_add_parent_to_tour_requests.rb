class AddParentToTourRequests < ActiveRecord::Migration[5.1]
  def change
    add_reference :tour_requests, :user, foreign_key: true
  end
end
