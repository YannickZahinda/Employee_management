class ChangeDateToDatetimeInAttendances < ActiveRecord::Migration[7.0]
  def up
    change_column :attendances, :date, :datetime
  end

  def down
    change_column :attendances, :date, :date
  end
end