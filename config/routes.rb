Rails.application.routes.draw do

  root 'welcome#index'

  get :partner, to: 'teachers#new'

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    member do
      get :set_password
      patch :update_password
    end
  end
  resources :teacher_profiles

  namespace :admin do
    get '', to: "teachers#index"
    resources :teachers, only: [:index] do
      member do
        patch :approve
      end
    end
  end

end
