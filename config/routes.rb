Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      patch :update
      get :logged_in
      get :associated_oupas
      resources :sessions, only: [:create] do
        collection do
          post :renew
          post :invalidate_all
        end
      end
    end
    resources :personal_medicine_reminder, only: [:index]
    resources :contacts, only: [:index]
    resources :measurements, only: [:index]
  end

  resources :assistant_users, only: [] do
    put :elderly_user, to: 'assistant_users#associate_elderly_user'
  end

  resources :personal_medicine_reminder, only: [:create, :index, :update] do
    collection do
      delete :delete_all
      post :alexa
    end
  end

  resources :emergency_alarm, only: [:create]
  resources :contacts, only: [:create, :index, :update]
  resources :measurements, only: [:create, :index, :update] do
    collection do
      delete :delete_all
    end
  end
end
