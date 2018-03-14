Rails.application.routes.draw do

  root 'welcome#index'

  get 'about', to: 'welcome#about'
  get 'terms_of_use', to: 'welcome#terms_of_use'
  get 'privacy_policy', to: 'welcome#privacy_policy'
  get 'search', to: 'welcome#search'
  get 'show', to: 'welcome#show'
  get 'check_email', to: 'welcome#check_email'
  get :dashboard, to: 'teachers#dashboard', as: :dashboard


  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    member do
      get :set_password
      patch :update_password
      post :set_availability
      get :availability
      match :bank_account, via: [:get, :post]
      get :get_price
      get :get_schedule
      post :tour_booking
    end
    collection do
      get :get_availability
      get :bank_account_detail
    end
  end

  get '/parents/check_email_availability', to: 'parents#check_email_availability'
  get '/parents/dashboard', to: 'parents#dashboard'

  resources :parent_profiles

  resources :teacher_profiles do
    member do
      get :request_info
    end
  end

  resources :parents, only: [:create] do
    collection do
      get :login
      get :child_birth
      get :set_child_admission
    end
  end

  namespace :admin do
    get '', to: "teachers#index", as: :dashboard
    resources :teachers, only: [:index, :edit, :update] do
      member do
        match :price, via: [:get, :post]
        get :teacher_price
        get :edit_profile
        patch :approve
        patch :reject
      end
    end
  end
  get '/partner', to: "teachers#new", as: :partner
end
