Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      resources :sessions, only: [:create] do
        collection do
          post :renew
          post :invalidate_all
        end
      end
    end
  end
end
