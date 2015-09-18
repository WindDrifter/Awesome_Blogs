Rails.application.routes.draw do


  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create] do
    collection do
      get   :edit
      patch :update
    end
  end

  resources :blogs do
    resources :comments, only: [:create, :update, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :categories, only: [:show]

  root 'home#index'

end
