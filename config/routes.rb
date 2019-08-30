Rails.application.routes.draw do

  devise_for :users, only: :omniauth_callbacks,
             :controllers => { omniauth_callbacks: 'users/omniauth_callbacks'}

  scope "/:locale" , locale: /#{I18n.available_locales.join('|')}/ do

    devise_for :users, skip: :omniauth_callbacks
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

    get 'categories/:category_slug/:id', to: 'images#show', as: 'category_image_new'
    mount Resque::Server.new, at: "/resque"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
