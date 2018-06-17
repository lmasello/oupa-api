Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      patch :update
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

  resources :personal_medicine_reminder, only: [:create, :index, :update]
  resources :emergency_alarm, only: [:create]
end
