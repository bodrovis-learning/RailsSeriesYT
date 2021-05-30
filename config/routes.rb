Rails.application.routes.draw do
  get '/questions', to: 'questions#index'

  root 'pages#index'
end
