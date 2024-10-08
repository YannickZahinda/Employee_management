class CreateQrCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :qr_codes do |t|
      t.string :code
      t.datetime :expires_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
