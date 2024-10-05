class AddStatusToSickLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :sick_leaves, :status, :integer
  end
end
