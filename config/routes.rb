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
  post '/questions/:id', to: 'answers#create'
  get '/answers/:id', to: 'answers#show'
  get '/questions/:question_id/answers/:answer_id/edit', to: 'answers#edit'
  patch '/questions/:question_id/answers/:answer_id', to: 'answers#update'
  delete '/questions/:question_id/answers/:answer_id/delete', to: 'answers#destroy'
end
