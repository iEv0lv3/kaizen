Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/callbacks' }

  root to: 'welcome#index'

  devise_scope :user do
    get 'profile', to: 'users/profile#show'
    get 'profile/edit', to: 'users/profile#edit'
    get 'profile/edit_password', to: 'users/profile#edit_password'
    patch 'profile', to: 'users/profile#update'
    match 'users/:id' => 'users/profile#destroy', :via => :delete, :as => :destroy_user
    get 'questions/new', to: 'users/questions#new'
  end

  get 'technical_forum', to: 'technical_forum#index'
  get 'professional_forum', to: 'professional_forum#index'
  get '/questions/:id', to: 'questions#show'


  get '/questions/:id/answers/new', to: 'answers#new'
  get '/answers/:id', to: 'answers#show'
end
