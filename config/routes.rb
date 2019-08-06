Rails.application.routes.draw do

  devise_for :users,
             :controllers => { omniauth_callbacks: 'users/omniauth_callbacks',
                               sessions: 'users/sessions'}
  root 'static_pages#index'

  get 'images', to: 'images#index'
  get 'comments', to: 'comments#all'
  get 'profile', to: 'static_pages#profile'

  # resources :categories, shallow: true do
  resources :categories, param: :slug do
    resources :images, except: [:update, :edit] do
      resources :comments, shallow: true
      resources :likes, only: [:create, :destroy]
    end
  end

  get 'categories/:category_slug/:id', to: 'images#show', as: 'category_image_new'

end
