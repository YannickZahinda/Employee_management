class AddUserIdToSickLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :sick_leaves, :user_id, :integer
  end
end
