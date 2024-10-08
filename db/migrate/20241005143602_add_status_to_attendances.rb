class AddStatusToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :status, :integer
  end
end
