Rails.application.routes.draw do
  resources :questions do
    resources :answers, except: %i[new show]
  end

  root 'pages#index'
end
