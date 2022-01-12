class CreateOtpDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :otp_details do |t|
      t.integer :otp
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
