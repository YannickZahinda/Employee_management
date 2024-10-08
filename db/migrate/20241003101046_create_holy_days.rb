class CreateHolyDays < ActiveRecord::Migration[7.0]
  def change
    create_table :holy_days do |t|

      t.timestamps
    end
  end
end
