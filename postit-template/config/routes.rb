PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy]

=begin
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
=end

end
