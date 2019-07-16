Rails.application.routes.draw do

  root 'static_pages#index'

  resources :categories do
    resources :images
  end

end
