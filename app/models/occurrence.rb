class Occurrence < ActiveRecord::Base
  belongs_to :event, inverse_of: :occurrences 
  before_save :set_expiration_date 

  validates :start_date, presence: true 
  validate :dates_are_not_in_the_past, :dates_are_within_one_year,  unless: ->(o){ o.start_date.blank? }

  after_destroy :destroy_event, if: :was_final_occurrence?

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

  def dates_are_within_one_year
   if start_date > 1.year.from_now || (end_date && end_date > 1.year.from_now)
    errors.add(:base, 'Event must fall within 1 year from today')
   end
  end

  def was_final_occurrence?
   event.occurrences.count.zero?
  end

  def destroy_event
   event.destroy 
  end

end
