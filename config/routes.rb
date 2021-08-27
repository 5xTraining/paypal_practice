Rails.application.routes.draw do
  devise_for :users

  resource :cart, only: [:show, :destroy] do
    post :add, path: "add/:id"
  end

  resources :orders, only: [:index, :show, :create] do
    collection do
      get :checkout
    end

    member do
      delete :cancel
    end
  end

  root "products#index"
end
