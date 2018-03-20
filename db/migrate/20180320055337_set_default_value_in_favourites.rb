class SetDefaultValueInFavourites < ActiveRecord::Migration[5.1]
  def change
  	change_column :favourites, :status, :boolean, :default => "true"
  end
end
