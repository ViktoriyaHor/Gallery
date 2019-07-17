Rails.application.routes.draw do

  root 'static_pages#index'

  resources :categories, shallow: true do
    resources :images
  end

end
