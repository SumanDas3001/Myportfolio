class OtpDetail < ApplicationRecord
  belongs_to :user, optional: true
end
