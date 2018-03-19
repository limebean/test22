class AddPlaceOfBirthFieldToChild < ActiveRecord::Migration[5.1]
  def change
    add_column :children, :place_of_birth, :string
  end
end
