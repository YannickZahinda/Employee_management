class AddWorkedHoursToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :worked_hours, :decimal
  end
end
