Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/callbacks' }

  root to: 'welcome#index'

  devise_scope :user do
    get '/profile', to: 'users/profile#show'
    get '/profile/edit', to: 'users/profile#edit'
    get '/profile/edit_password', to: 'users/profile#edit_password'
    patch '/profile', to: 'users/profile#update'
    match '/users/:id' => 'users/profile#destroy', :via => :delete, :as => :destroy_user
    # delete '/users/:id', to: 'users#destroy'
    get '/questions/new', to: 'users/questions#new'

    scope module: :users do
      scope :questions do
        get '/:question_id/answers/new', to: 'answers#new', as: 'new_answer'
        post '/:question_id/answers', to: 'answers#create', as: 'create_new_answer'
        get '/:question_id/answers/:answer_id/edit', to: 'answers#edit', as: 'edit_answer'
        patch '/:question_id/answers/:answer_id', to: 'answers#update', as: 'update_answer'
        delete '/:question_id/answers/:answer_id/delete', to: 'answers#destroy', as: 'delete_answer'
      end
    end
  end

  get 'technical_forum', to: 'technical_forum#index'
  get 'professional_forum', to: 'professional_forum#index'
  get '/questions/:id', to: 'questions#show'
end
