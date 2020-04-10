Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    get 'profile', to: 'users/profile#show'
    get 'profile/edit', to: 'users/profile#edit'
    get 'profile/edit_password', to: 'users/profile#edit_password'
    patch 'profile', to: 'users/profile#update'
    get 'questions/new', to: 'users/questions#new'
  end

  root to: 'welcome#index'
end
