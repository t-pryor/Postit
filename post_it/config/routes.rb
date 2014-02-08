PostitTemplate::Application.routes.draw do

  root to: 'posts#index'

  get '/register', to: 'users#new', as: 'register'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'



  resources :posts, except: [:destroy] do
      member do
        post :vote
      end

      resources :comments, only: [:create] do
        member do
          post :vote
        end
      end

  end

  resources :categories, only: [:index, :new, :create, :show]

  resources :users, only: [:show, :create, :edit, :update] #not index, new, delete     #limit this later only [:create]  5-2, 14:00

end
