class AddAdminIdToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :admin_id, :integer
  end
end
