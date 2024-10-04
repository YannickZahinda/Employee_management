class AddDetailsToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :title, :string
    add_column :meetings, :description, :text
    add_column :meetings, :start_time, :datetime
    add_column :meetings, :end_time, :datetime
  end
end
