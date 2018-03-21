class CreateAdminInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_infos do |t|
      t.string :name
      t.string :document
      t.timestamps
    end
  end
end
