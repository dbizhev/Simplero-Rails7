Rails.application.routes.draw do
  devise_for :users,
             path: '',
             only: %w[sessions registrations],
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  root 'groups#index'
  resource :groups, only: :index
end
