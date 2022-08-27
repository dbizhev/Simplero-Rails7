Rails.application.routes.draw do
  devise_for :users,
             path: '',
             only: %w[sessions registrations],
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  root 'groups#index'
  resources :groups, only: [:index, :new, :create] do
    collection do
      post :search
    end
    member do
      post :join
      post :remove_member
      post :respond_join_request
    end
    resources :posts do
      resources :comments
    end
  end
end
