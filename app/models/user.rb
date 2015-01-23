class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #omniauthable,:omnitauth_proivder => [:facebook]
 
  has_one :profile, dependent: :destroy 
  accepts_nested_attributes_for :profile
  #delegate :full_name, :current_location, :gender, :age, to: :profile 

  validates_presence_of :profile 


  # token auth

  # has_many :spots
  # has_many :events

  # has_many :favorites, dependent: :destroy
  # has_many :favorite_spots, through: :favorites, source: :spot

  # has_many :checkins, dependent: :destroy
end
