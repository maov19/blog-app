Rails.application.routes.draw do
  # Route for displaying all posts for a specific user
  get 'users/:user_id/posts', to: 'posts#index', as: 'user_posts'

  # Route for displaying a specific post and its comments
  get 'users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'

  # Route for displaying all user names
  get 'users', to: 'users#index'

  # Route for displaying a specific user and their posts
  get 'users/:id', to: 'users#show', as: 'user'
end

