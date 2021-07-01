Rails.application.routes.draw do
  resources :questions do
    resources :answers, only: %i[create destroy]
  end

  root 'pages#index'
end
