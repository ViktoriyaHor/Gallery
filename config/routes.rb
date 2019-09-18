Rails.application.routes.draw do

  devise_for :users,
             :controllers => { omniauth_callbacks: 'users/omniauth_callbacks',
                               sessions: 'users/sessions'}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#index'

  get 'images', to: 'images#index'
  get 'comments', to: 'comments#all'
  get 'profile', to: 'static_pages#profile'

  # resources :categories, shallow: true do
  resources :categories, param: :slug do
    resources :subscriptions, only: [:create, :destroy]
    resources :images, except: [:update, :edit] do
      resources :comments, shallow: true
      resources :likes, only: [:create, :destroy]
    end
  end

  get 'images/new', to: 'images#extended_new'
  match "images/new" => "images#extended_create", :via => :post

  get 'categories/:category_slug/:id', to: 'images#show', as: 'category_image_new'
  # mount Resque::Server.new, at: "/resque"

end
