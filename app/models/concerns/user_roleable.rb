module UserRoleable 
  extend ActiveSupport::Concern
  
  included do 
    with_options as: :resource, class_name: 'UserRole', dependent: :delete_all do 
      has_many :admin_roles,  ->{ admins }
      has_many :editor_roles, ->{ editors }
    end
    with_options source: :user do 
      has_many :admin_users, through: :admin_roles
      has_many :editor_users, through: :editor_roles
    end
    validates_presence_of :admin_roles
  end

end