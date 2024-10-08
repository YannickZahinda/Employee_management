class CreateSickLeaves < ActiveRecord::Migration[7.0]
  def change
    create_table :sick_leaves do |t|

      t.timestamps
    end
  end
end
