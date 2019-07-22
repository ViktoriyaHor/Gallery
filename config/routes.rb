Rails.application.routes.draw do

  root 'static_pages#index'

  get 'images/index'

  # resources :categories, shallow: true do
    resources :categories do
      resources :images
  end



end
