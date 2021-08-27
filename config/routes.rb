Rails.application.routes.draw do
  devise_for :users

  resource :cart, only: [:show, :destroy] do
    post :add, path: "add/:id"
  end

  root "products#index"
end
