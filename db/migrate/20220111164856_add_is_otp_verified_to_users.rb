class AddIsOtpVerifiedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_otp_verified, :boolean, default: false
  end
end
