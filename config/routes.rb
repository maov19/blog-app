Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'password',
    confirmation: 'verification',
    unlock: 'unlock',
    sign_up: 'signup',
    edit: 'edit'
  }

  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  resources :posts, only: [:new, :create, :destroy] # Move the delete route here

  delete '/users/:user_id/posts/:id', to: 'posts#destroy', as: 'destroy_user_post' # Use a different name for the delete route

end
