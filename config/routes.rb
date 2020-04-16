Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :posts
  end

  get 'posts/:id/repost' => 'posts#repost', as: :repost
  get 'count_repost_of_initial_post' => 'posts#count_repost_of_initial_post'
end
