class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :position, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :sex, :string
    add_column :users, :date_of_joining, :date
    add_column :users, :id_card, :string
  end
end