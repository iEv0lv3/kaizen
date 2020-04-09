Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    get 'profile', to: 'users/profile#show'
  end

  root to: 'welcome#index'
end
