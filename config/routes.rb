Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' },
                     :path => 'accounts'

  resources :users, only: [:index, :show] do
    resources :posts, except: [:index, :show]
  end
  resources :categories, except: [:delete]
  resources :comments, only: [:create, :destroy]
  
  delete 'users/:id', to: 'users#destroy', :via => :delete, :as => :admin_destroy_user
  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show', as: 'post'
  root 'welcome#index'
end
