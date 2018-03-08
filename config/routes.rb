Rails.application.routes.draw do

  root 'welcome#index'

  get 'about', to: 'welcome#about'
  get 'terms_of_use', to: 'welcome#terms_of_use'
  get 'privacy_policy', to: 'welcome#privacy_policy'
  get 'search', to: 'welcome#search'
  get 'show', to: 'welcome#show'

  get :dashboard, to: 'teachers#dashboard', as: :dashboard


  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    member do
      get :set_password
      patch :update_password
      post :set_availability
      get :availability
      match :bank_account, via: [:get, :post]
    end
    collection do
      get :get_availability
      get :bank_account_detail
    end
  end

  get '/parents/check_email_availability', to: 'parents#check_email_availability'
  get '/parents/dashboard', to: 'parents#dashboard'

  resources :teacher_profiles

  namespace :admin do
    get '', to: "teachers#index", as: :dashboard
    resources :teachers, only: [:index, :edit, :update] do
      member do
        get :edit_profile
        patch :approve
        patch :reject
      end
    end
  end
  get '/partner', to: "teachers#new", as: :partner
end
