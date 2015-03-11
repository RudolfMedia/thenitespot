class Occurrence < ActiveRecord::Base
  belongs_to :event, inverse_of: :occurrences 
  before_save :set_expiration_date 

  validates :start_date, presence: true 
  validate :dates_are_not_in_the_past, unless: ->(o){ o.start_date.blank? }

  after_save :update_event_expiration_date, if: :is_final_occurrence?
  
  scope :upcoming, ->{ where("expiration_date >= ?", DateTime.now.beginning_of_day).order(:start_date) }

private

  def set_expiration_date
   self.expiration_date = end_date || start_date
  end

  def dates_are_not_in_the_past
   if start_date < Date.today || (end_date && end_date < Date.today)
    errors.add(:base, 'Provided dates cannot be in the past.')
   end 
  end

  def is_final_occurrence?
    Occurrence.where(event_id: self.event_id).order(expiration_date: :desc).first == self 
  end 

  def update_event_expiration_date
    event.update_attribute(:expiration_date, self.expiration_date)
  end

end
