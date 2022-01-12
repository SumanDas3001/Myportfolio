class AddUserOtpDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :otp, :integer
    add_column :users, :otp_sent_at, :datetime
  end
end
