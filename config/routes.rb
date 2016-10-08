Rails.application.routes.draw do
  

  get  'tests/start'
  post 'tests/ready'

  #get 'tests/question'

  get  'tests/result'
  post 'tests/create'

  root to: 'welcome#index'  
  

  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get    'create', to: 'words#new'
  get    'books' , to: 'words#books'
  get    'signup', to: 'users#new'

  resources :users do
    member do
      get :followings, :followers, :userwords,
          :favorites
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :words do
    resource :favorite, only: [:create, :destroy]
  end

  resources :sessions, only: [:new, :create, :destroy]
end
