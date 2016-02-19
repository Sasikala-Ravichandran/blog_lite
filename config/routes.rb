Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' },
                     :path => 'accounts'

  resources :users
  
  root 'welcome#index'
end
