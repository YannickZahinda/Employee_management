class AddDateToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :date, :date
  end
end
