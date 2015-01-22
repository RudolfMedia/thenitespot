class Profile < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :first_name, :last_name, :dob, :gender, :current_city, :current_state
  validates :first_name, :last_name, :current_city, length: { in: 2..25 }
  validates :current_state, length: { is: 2 }  
  validates :dob, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }, length: { maximum: 10 }
  validates :gender, inclusion: { in: %w( male female ) }
  validate :is_atleast_18, if: Proc.new { |p| p.dob.kind_of?(Date) }

  #has_one :avatar, ->{ where(is_primary: :true) }, as: :imagable, class_name: 'Photo', dependent: :destroy

  def age
    (Date.today - dob) / 365
  end

private 

  def is_atleast_18
    unless dob.to_date < 18.years.ago.to_date  
      errors.add(:dob, 'Must be 18 years of age to sign up.')
    end
  end

  
end
