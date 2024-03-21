require 'sidekiq/web'

Rails.application.routes.draw do

  # Old redirects
  draw :redirects

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]

  #  Trix youtube plugin
  resource :embed, only: :update

  # services
  resources :testimonials

  namespace :services do
    resources :service_prices
    resources :sample_developmental_edits do 
      put 'sample_developmental_edit_accepted' => 'state_buttons#sample_developmental_edit_accepted', on: :member
      put 'sample_developmental_edit_rejected' => 'state_buttons#sample_developmental_edit_rejected', on: :member
    end
    resources :developmental_edits do
      put 'developmental_edit_accepted' => 'state_buttons#developmental_edit_accepted', on: :member
      put 'developmental_edit_rejected' => 'state_buttons#developmental_edit_rejected', on: :member
    end

    root to: "pages#index"
  end

  # service pages
  scope '/services', controller: :service_pages do
    get 'developmental-editing'
    get 'content-editing', action: :developmental_editing
    get 'substantive-editing', action: :developmental_editing
    get 'novel-editing', action: :developmental_editing
    get 'manuscript-editing', action: :developmental_editing
    get 'book-editing', action: :developmental_editing
    get 'mentoring'
    get 'manuscript-assessment'
    get 'copy-editing'
  end

  # Static pages
  scope controller: :static_pages do
    get 'about'
    get 'thanks'
    get 'file-safety'
    get 'book-editing-portal'
    get 'terms-and-conditions'
    get 'privacy-policy'  
  end

  # For price calculator
  get 'calculate_price', to: 'customer_pages#calculate_price'

  # Dashboard
  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  # Blog
  namespace :blog do
    resources :post_authors, :post_categories
    resources :posts, path: '' do
      put 'publish' => 'posts#publish', on: :member, as: :publish
      put 'unpublish' => 'posts#unpublish', on: :member, as: :unpublish
    end
    root to: "posts#index"
  end

  # Messages
  resources :messages do
    put 'read' => 'messages#read', on: :member, as: :read
    put 'unread' => 'messages#unread', on: :member, as: :unread
    put 'archive' => 'messages#archive', on: :member, as: :archive
    put 'unarchive' => 'messages#unarchive', on: :member, as: :unarchive
  end
  get '/thank-you', to: 'messages#thank_you'

  # Mailing List
  resources :mailing_lists

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Users
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations', sessions: 'users/sessions' } 

  # Services
  resources :users do
    resources :books
  end 

  resources :books, only: [] do
    resources :orders do
      member do
        post 'accept'
        post 'reject'
        post 'invoice_sent'
        post 'invoice_paid'
        post 'invoice_unpaid'
      end
    end      
  end

  # Courses
  resources :courses do
    resources :lessons, except: :index
  end

  # eBooks
  resources :ebooks

  get 'free_signup', to: 'free_resources_registrations#free_signup', as: 'free_signup'
  get 'paid_signup', to: 'free_resources_registrations#paid_signup', as: 'paid_signup'  

  # Products
  resources :products

  # Genres
  resources :genres

  root to: 'service_pages#index'

end