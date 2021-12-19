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
         :recoverable, :rememberable, :validatable

  validates_presence_of :name

  has_many :comments, dependent: :destroy

  has_many :user_favorite_blogs, -> { where('is_favorited = true') }, dependent: :destroy
  has_many :blogs, through: :user_favorite_blogs

  after_create :send_welcome_mail

  def first_name
  	return self.name.split.first
  end

  def send_welcome_mail
    UserMailer.send_welcome(self.email, self.name).deliver
  end

end
