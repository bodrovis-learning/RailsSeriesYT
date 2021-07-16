Rails.application.routes.draw do
  resources :users, only: %i[new create]
  
  resources :questions do
    resources :answers, except: %i[new show]
  end

  root 'pages#index'
end
