class Spot < ActiveRecord::Base
  include Categorizable 
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :neighborhood

  PRICE_RANGES 	  = { '$' => 'low pricing', '$$' => 'moderate pricing', '$$$' => 'high pricing', '$$$$' => 'fine dining' }
  PAYMENT_OPTIONS = ['cash', 'visa', 'mastercard', 'amex', 'discover']
  
  geocoded_by :address 
  before_validation :geocode, if: ->(s){ s.address.present? && s.address_changed? }

  validates_presence_of :name, :street, :city, :state #, :zip  needed?
  validates :name, length: { in: (3..30) }, exclusion: { in: %w( eat drink attend ) }
  validate :eat_drink_or_attend?
  validates_numericality_of :longitude, :latitude, message: 'Unable to locate given address' 
  #validate :neighborhood_exists?, unless: ->(s){ s.neighborhood_id.blank? }
  validate :valid_payment_options?, unless: ->(s){ s.payment_opts.blank? }

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
  
  validates_each :categorizations do |spot, attr, value|
    spot.errors.add attr, "6 category max." unless spot.categorizations.size <= 6
  end

  def address
  	return unless street && city && state 
  	[ street, city, state ].join(', ').titleize
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
    unless ( payment_opts - PAYMENT_OPTIONS ).empty?
      errors.add(:payment_opts, 'Invalid payment option selected')
    end 
  end

  # def neighborhood_exists?
  # 	unless Neighborhood.exists?(neighborhood_id)
  # 	  errors.add(:neighborhood, 'Invalid neighborhood selection')
  # 	end
  # end

  def slug_candidates
  	[ :name, [ :name, :city ], [ :name, :street, :city ] ]
  end

end
