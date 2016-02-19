Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' },
                     :path => 'accounts'
  root 'welcome#index'
end
