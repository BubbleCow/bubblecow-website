require 'sidekiq/web'

Rails.application.routes.draw do
  resources :post_categories
  resources :post_authors
  resources :posts
  namespace :admin do
    resources :users
    resources :announcements
    resources :notifications
    resources :services
    root to: "users#index"
  end

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  get '/about', to: 'home#about'

  # Editorial Services
  get '/book-editing', to: 'editorial_services#book_editing'
  get '/copy-editing', to: 'editorial_services#copy_editing'
  get '/full-service', to: 'editorial_services#full_service'
  get '/pricing', to: 'editorial_services#pricing'  

  # Blog
  namespace :blog do
    resources :post_authors, :post_categories
    resources :posts, path: '' do
      put 'publish' => 'posts#publish', on: :member, as: :publish
      put 'unpublish' => 'posts#unpublish', on: :member, as: :unpublish
    end
    root to: "posts#index"
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
