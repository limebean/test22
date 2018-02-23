Rails.application.routes.draw do

  root 'welcome#index'

  get 'about', to: 'welcome#about'
  get 'terms_of_use', to: 'welcome#terms_of_use'
  get 'privacy_policy', to: 'welcome#privacy_policy'

  get :dashboard, to: 'teachers#dashboard', as: :dashboard


  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    
    member do
      get :set_password
      patch :update_password
    end
  end
  resources :teacher_profiles

  namespace :admin do
    get '', to: "teachers#index", as: :dashboard
    resources :teachers, only: [:index, :edit, :update] do
      member do
        patch :approve
        patch :reject
      end
    end
  end
  get '/partner', to: "teachers#new", as: :partner
end
