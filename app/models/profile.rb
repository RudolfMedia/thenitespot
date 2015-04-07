class Profile < ActiveRecord::Base
  belongs_to :user
  
  # has_many :images, as: :imageable, dependent: :destroy
  has_one :avatar, as: :imageable, class_name: 'Image', dependent: :destroy 

  validates_presence_of :first_name, :last_name, :dob, :gender, :current_city, :current_state
  validates :first_name, :last_name, :current_city, length: { in: 2..25 }
  validates :current_state, length: { is: 2 }  
  validates :dob, length: { is: 10 }
  validates :gender, inclusion: { in: %w( male female ) }
  validate  :is_atleast_18

  #has_one :avatar, ->{ where(is_primary: :true) }, as: :imagable, class_name: 'Photo', dependent: :destroy
  
  def full_name
  	[ first_name, last_name ].join(' ').titleize 
  end

  def current_location
  	[ current_city, current_state ].join(', ').titleize 
  end

  def current_location=(value)
    self.current_city, self.current_state = value.split(',').map(&:strip)
  end

  def age
    now = Date.today
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

private 

  def is_atleast_18
    unless !dob.is_a?(Date) || dob.to_date < 18.years.ago.to_date  
      errors.add(:dob, 'Must be 18 years of age to sign up.')
    end
  end


end
