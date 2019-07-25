Rails.application.routes.draw do

  root 'static_pages#index'

  get 'images/index'

  # resources :categories, shallow: true do
  resources :categories, param: :slug do
    resources :images do
      resources :comments, shallow: true
      resources :likes
    end
  end

  get 'categories/:category_slug/:id', to: 'images#show', as: 'category_image_new'

end
