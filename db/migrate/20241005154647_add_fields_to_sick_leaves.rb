class AddFieldsToSickLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :sick_leaves, :start_date, :date
    add_column :sick_leaves, :end_date, :date
    add_column :sick_leaves, :reason, :text
  end
end
