class AddReportTypeToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :report_type, :string
  end
end
