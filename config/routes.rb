Rails.application.routes.draw do
  namespace :api do
    get 'comments/index'
  end
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
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
  resources :posts, only: [:new, :create, :destroy]
  resources :comments, only: [:destroy], as: 'destroy_comment_post'

  delete '/users/:user_id/posts/:id', to: 'posts#destroy', as: 'destroy_user_post' 

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index] do
      resources :posts, only: [:index] do
       resources :comments, only: [:index, :create]
        end
      end
   end
end