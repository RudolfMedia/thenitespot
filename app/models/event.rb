class Event < ActiveRecord::Base
  include Categorizable
  include Imageable
  extend FriendlyId

  friendly_id :name, use: :slugged #*
  belongs_to :spot

  has_many :occurrences, dependent: :delete_all
  accepts_nested_attributes_for :occurrences, reject_if: :all_blank, allow_destroy: true

  has_many :reports, as: :reportable, dependent: :destroy 

  validates_each :occurrences do |event, attr, value|
    if event.occurrences.size >= 6
      event.errors.add attr, "An event may have up to 5 seperate occurrences."
    end 
  end

  validates_presence_of :name, :spot_id, :age, :entry, :occurrences
  validates :name, length: { in:  (3..45) }, unreserved_name: true 
   
  AGES = [ 'all ages', '18+', '21+' ]
  ENTRY_TYPES = [ 'free', 'cover', 'ticket' ]

  validates :age, inclusion: { in: AGES }
  validates :entry, inclusion: { in: ENTRY_TYPES }
  validates :entry_fee, presence: true, if: ->(e){ ENTRY_TYPES.last(2).include? e.entry }

  with_options allow_blank: true do 
    validates :about, length: { maximum: 500 }
    validates :email, email: true
    validates :phone, length: { maximum: 25 } 

    with_options url: true do
     validates :ticket_url 
     validates :website_url
     validates :facebook_url
     validates :twitter_url 
    end
  end

  validates_each :categorizations do |event, attr, value|
    event.errors.add attr, '6 category max.' unless event.categorizations.size <= 6
  end
 
  scope :upcoming, ->{ joins(:occurrences).merge(Occurrence.upcoming) }

  def normalize_friendly_id(string)
    super(string.gsub("'", ""))
  end

end
