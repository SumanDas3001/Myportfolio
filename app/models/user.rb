class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:site_admin], multiple: false)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: [:github, :google_oauth2, :twitter]

  validates_presence_of :name

  has_many :comments, dependent: :destroy

  has_many :user_favorite_blogs, -> { where('is_favorited = true') }, dependent: :destroy
  has_many :blogs, through: :user_favorite_blogs
  has_many :otp_details, dependent: :destroy

  # after_create :send_welcome_mail

  OTP_EXPIRY_TIME = 2 # In minutes

  def first_name
  	return self.name.split.first
  end

  def send_welcome_mail
    UserMailer.send_welcome(self.email, self.name).deliver
  end

  def self.generate_otp
    rand(1000..9999)
    # 1234
  end

  def get_otp_sent_count_last_24_hour
    from_time = Time.now-24.hours
    to_time = Time.now
    otp_details.where('created_at BETWEEN ? AND ?', from_time , to_time).count
  end

  def add_otp_details
    otp_details.create(otp: self.otp)
  end

  def remove_otp_details
    otp_details.destroy_all if otp_details.present?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    user ||= User.create(
      email: data["email"],
      password: Devise.friendly_token[0, 20]
    )

    user.name = access_token.info.name
    user.image = access_token.info.image
    user.provider = access_token.provider
    user.uid = access_token.uid
    user.save

    user
  end

end
