Rails.application.routes.draw do
  root 'relationships#index'
  get  'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  resources :relationships, only: [:index]
  get '/voter/next',            to: 'voter#next' # without an id = get first available voter
  get '/voter/:id/next',        to: 'voter#next' # with an id = get voter after current voter
  post '/voter/:id/update_survey', to: 'voter#update_survey'
  resources :voter, only: [:show, :update, :update_survey]

  get 'verify', to: 'users#verify', as: 'verify'
  post 'verify', to: 'users#verify'

  get 'imports', to: 'imports#index'
  post 'imports', to: 'imports#create'
end
