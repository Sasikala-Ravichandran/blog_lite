Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' },
                     :path => 'accounts'

  resources :users do
    resources :posts, except: [:index]
  end
  
  get 'posts', to: 'posts#index'
  root 'welcome#index'
end
