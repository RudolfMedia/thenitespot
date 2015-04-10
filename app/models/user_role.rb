class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, polymorphic: true

  enum role: [ :admin, :editor ]

  validates_presence_of :user 
  validates_inclusion_of :role, in: roles 
  validates_uniqueness_of :user, scope: [ :resource_type, :resource_id ], message: 'User already assigned.'

  scope :admins,  ->{ where role: 0 }
  scope :editors, ->{ where role: 1 }

  after_destroy do 
    if !resource.valid? 
      raise "#{resource_type} requires aleast 1 administraive user."
    end
  end
end
