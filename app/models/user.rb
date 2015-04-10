class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #omniauthable,:omnitauth_proivder => [:facebook]
  
  has_one :profile, dependent: :destroy, inverse_of: :user 
  accepts_nested_attributes_for :profile

  delegate :first_name, 
           :last_name, 
           :full_name, 
           :current_location, 
           :gender, 
           :age, 
           :avatar, to: :profile

  has_many :user_roles, dependent: :restrict_with_error
  has_many :spots, through: :user_roles, source: :resource, source_type: 'Spot' 

  validates_uniqueness_of :auth_token 
  validates_presence_of :profile 

  before_create :set_auth_token, unless: ->(u){ u.auth_token.present? } #before_validation to sign up with facebook?

  # has_many :spots
  # has_many :events

  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :spot 

  has_many :checkins, dependent: :destroy

  has_many :reports, dependent: :destroy 

  #omniauth 

  default_scope ->{ includes(:profile) }

  def is_admin_of?(resource)
    user_roles.admins.exists? resource: resource 
  end 

  def can_update?(resource)
    user_roles.exists? resource: resource 
  end
  
private
  
  def set_auth_token
  	self.auth_token = generate_auth_token
  end

  def generate_auth_token
  	loop do
      token = Devise.friendly_token
  	  break token unless self.class.exists?(auth_token: token)
    end 
  end

end
