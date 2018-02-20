Rails.application.routes.draw do
  root 'teachers#new'
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :teachers do
    member do
      resources :teacher_profiles
      get :new_password
      put :update_password
      get :approve
    end
  end

  namespace :admin do
    resources :teachers
  end

end
