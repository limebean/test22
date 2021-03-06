Rails.application.routes.draw do

  root 'welcome#index'

  get 'about', to: 'welcome#about'
  get 'terms_of_use', to: 'welcome#terms_of_use'
  get 'privacy_policy', to: 'welcome#privacy_policy'
  get 'search', to: 'welcome#search'
  get 'show', to: 'welcome#show'
  get 'check_email', to: 'welcome#check_email'
  get :dashboard, to: 'teachers#dashboard', as: :dashboard
  get 'faq_home_page', to: 'welcome#faq_home_page'
  get '/contact_us', to: 'welcome#contact_us', as: :contact
  post 'support', to: 'welcome#support'



  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    member do
      get :set_password
      patch :update_password
      post :set_availability
      get :availability
      get :child_enrollment
      match :bank_account, via: [:get, :post]
      get :get_price
      get :get_schedule
      post :tour_booking
      get :enroll_modal   
    end
    collection do
      get :document
      get :get_availability
      get :bank_account_detail
      get :manage_enrollment
    end
  end

  resources :children do
    member do
      get :abcd
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
    member do
      get :school
      get :interest_open_house
      match :payment, via: [:get, :post]
    end
    collection do
      get :change_favourite_status
      get :login
      get :child_birth
      get :set_child_admission
      put :toggle_favourite_status
    end
  end
  resources :enrollments do
    member do
      get :change_enrollment_status
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
        get :set_transaction
      end
      collection do
        match :upload_document, via: [:get, :post, :delete]
        get :document
        get :transaction_setting
      end
    end
    resources :parents
  end
  get '/partner', to: "teachers#new", as: :partner
end
