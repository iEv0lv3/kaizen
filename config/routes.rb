Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    omniauth_callbacks: 'users/callbacks',
    sessions: 'sessions'
  }

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_scope :user do
    get '/profile', to: 'users/profile#show'
    get '/profile/edit', to: 'users/profile#edit'
    patch '/profile', to: 'users/profile#update'
    match '/users/:id' => 'users/profile#destroy', :via => :delete, :as => :destroy_user

    get '/questions/new', to: 'users/questions#new'
    post '/questions', to: 'users/questions#create'
    get '/questions/:id/edit', to: 'users/questions#edit', as: :edit_question
    patch '/questions/:id/edit', to: 'users/questions#update'
    delete '/questions/:id', to: 'users/questions#destroy'

    scope module: :users do
      scope :questions do
        get '/:question_id/answers/new', to: 'answers#new', as: 'new_answer'
        post '/:question_id/answers', to: 'answers#create', as: 'create_new_answer'
        get '/:question_id/answers/:answer_id/edit', to: 'answers#edit', as: 'edit_answer'
        patch '/:question_id/answers/:answer_id', to: 'answers#update', as: 'update_answer'
        delete '/:question_id/answers/:answer_id/delete', to: 'answers#destroy', as: 'delete_answer'

        get '/:question_id/comments/new', to: 'question_comments#new', as: 'new_question_comment'
        post '/:question_id/comments', to: 'question_comments#create', as: 'create_new_question_comment'
        get '/:question_id/comments/:comment_id/edit', to: 'question_comments#edit', as: 'edit_question_comment'
        patch '/:question_id/comments/:comment_id', to: 'question_comments#update', as: 'update_question_comment'
        delete '/:question_id/comments/:comment_id/delete', to: 'question_comments#destroy', as: 'delete_question_comment'

        get '/:question_id/answers/:answer_id/comments/new', to: 'answer_comments#new', as: 'new_answer_comment'
        post '/:question_id/answers/:answer_id/comments', to: 'answer_comments#create', as: 'create_new_answer_comment'
        get '/:question_id/answers/:answer_id/comments/:comment_id/edit', to: 'answer_comments#edit', as: 'edit_answer_comment'
        patch '/:question_id/answers/:answer_id/comments/:comment_id', to: 'answer_comments#update', as: 'update_answer_comment'
        delete '/:question_id/answers/:answer_id/comments/:comment_id/delete', to: 'answer_comments#destroy', as: 'delete_answer_comment'
      end
    end

    post '/:id/verify', to: 'users/verification#verify_answer', as: 'verify_answer'
    post '/questions/:id', to: 'users/upvotes#question_upvotes', as: 'question_upvote'
    post '/questions/:id/answers/:id', to: 'users/upvotes#answer_upvotes', as: 'answer_upvote'
    post '/questions/:id/comments/:id', to: 'users/upvotes#question_comment_upvotes', as: 'question_comment_upvote'
    post '/questions/:id/answers/:id/comments/:id', to: 'users/upvotes#answer_comment_upvotes', as: 'answer_comment_upvote'
  end

  root to: 'welcome#index'

  get 'technical_forum', to: 'technical_forum#index'
  get 'professional_forum', to: 'professional_forum#index'
  get '/questions/:id', to: 'questions#show', as: 'question_show'

  get '/users/:id', to: 'users#show'
  get '/search', to: 'search#index', as: 'search'
end
