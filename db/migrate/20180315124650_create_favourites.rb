class CreateFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.belongs_to :parent, index: true
      t.belongs_to :teacher, index: true
      t.boolean :status
      t.timestamps
    end
  end
end
