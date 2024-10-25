class AddLocationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :last_known_location, :string
  end
end
