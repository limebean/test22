Rails.application.routes.draw do

  root 'welcome#index'

  get 'about', to: 'welcome#about'
  get 'terms_of_use', to: 'welcome#terms_of_use'
  get 'privacy_policy', to: 'welcome#privacy_policy'

  get :partner, to: 'teachers#new'

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    member do
      resources :teacher_profiles
      get :set_password
      patch :update_password
    end
  end

  namespace :admin do
    get '', to: "teachers#index"
    resources :teachers, only: [:index] do
      member do
        patch :approve
      end
    end
  end

end
