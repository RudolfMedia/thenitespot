require 'api_version'
Rails.application.routes.draw do

  devise_for :users
  
  namespace :api, defaults: { format: :json } do #  path: '/', constraints: { subdomain: 'api' }  
    scope module: :v1, contstraints: ApiVersion.new(1) do 

    end
  end
end
