module Daily
  extend ActiveSupport::Concern

  included do
    validates_presence_of :day 
    validate :valid_days_of_week?
    scope :current, ->{ where("#{table_name}.day @> ? ", "{#{DateTime.now.wday}}") }
  end
  
  def valid_days_of_week?
  	if !day.is_a?(Array) || day.find{ |d| !('0'..'6').include? d }
	  self.errors.add(:day, 'Invalid day selection')
    end
  end

end