Rails.application.routes.draw do




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

  root 'home#index'

end
