Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' },
                     :path => 'accounts'

  resources :users, only: [:index, :show] do
    resources :posts, except: [:index, :show]
  end
  
  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show', as: 'post'
  root 'welcome#index'
end
