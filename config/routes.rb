Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      get :logged_in
      resources :sessions, only: [:create] do
        collection do
          post :renew
          post :invalidate_all
        end
      end
    end
  end

  resources :assistant_users, only: [] do
    put :elderly_user, to: 'assistant_users#associate_elderly_user'
  end
end
