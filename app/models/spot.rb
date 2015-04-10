class Spot < ActiveRecord::Base
  include Categorizable 
  include UserRoleable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :neighborhood, counter_cache: true 
  
  has_many :events, dependent: :destroy 
  
  has_many :spot_features, dependent: :destroy 
  has_many :features, through: :spot_features

  has_many :hours, dependent: :destroy 

  has_many :specials, dependent: :destroy

  has_many :menus, dependent: :destroy  

  has_many :favorites, dependent: :destroy 
  has_many :favorite_users, through: :favorites, source: :user 

  has_many :checkins, dependent: :destroy

  has_many :images, as: :imageable, dependent: :destroy 
  #has_one  :primary_image, ->{ find_by(is_primary: true) }, as: :imageable, class_name: 'Image'
  #has_one :background_image, ->{ where(is_bg: true)}, as: :imageable, class_name: 'Photo'

  has_many :reports, as: :reportable, dependent: :destroy 

  PRICE_RANGES 	  = { '$' => 'low pricing', '$$' => 'moderate pricing', '$$$' => 'high pricing', '$$$$' => 'fine dining' }
  PAYMENT_OPTIONS = ['visa', 'mastercard', 'amex', 'discover']
  
  geocoded_by :address 
  before_validation :geocode, if: ->(s){ s.address.present? && s.address_changed? }

  validates_presence_of :name, :street, :city, :state #, :zip  needed?
  validates :name, length: { in: (3..30) }, unreserved_name: true 
  validate :eat_drink_or_attend?
  validates_numericality_of :longitude, :latitude, message: 'Unable to locate given address' 

  with_options allow_blank: true do 
  	validates :price, inclusion: { in: PRICE_RANGES.keys }
    validates :about, length: { maximum: 500 }
    validates :email, email: true

	  with_options url: true do 
	    validates :website_url
	    validates :reservation_url
	    validates :facebook_url
	    validates :twitter_url
	  end
  end 

  validate :valid_payment_options?, if: ->(s){ s.payment_opts.present? }
  
  validates_each :categorizations do |spot, attr, value|
    spot.errors.add attr, "6 category max." unless spot.categorizations.size <= 6
  end


  def primary_image
    images.find_by(is_primary: true)
  end

  def address
  	return unless street && city && state 
  	[ street, city, state ].join(', ').titleize
  end

  def price_range
    Spot::PRICE_RANGES[price] if price 
  end

  def address_changed?
  	street_changed? || city_changed? || state_changed? #|| zip_changed? 
  end

  def normalize_friendly_id(string)
    super(string.gsub("'", ""))
  end

  def self.geolocate(position, radius)
    where(id: self.near(position,radius, select: "#{table_name}.id").map(&:id))
  end

private

  def eat_drink_or_attend?
  	unless eat || drink || attend 
  	  errors.add(:base, 'Must select atleast one primary service.')
  	end
  end

  def valid_payment_options?
    if !payment_opts.is_a?(Array) || payment_opts.find{ |opts| !PAYMENT_OPTIONS.include? opts } 
      errors.add(:payment_opts, 'Invalid payment option selected')
    end
  end

  def slug_candidates
  	[ :name, [ :name, :city ], [ :name, :street, :city ] ]
  end

end
