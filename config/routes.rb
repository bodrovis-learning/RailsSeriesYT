# frozen_string_literal: true

Rails.application.routes.draw do
  concern :commentable do
    resources :comments, only: %i[create destroy]
  end

  namespace :api do
    resources :tags, only: :index
    resources :questions, only: :index
  end

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]

    resources :questions, concerns: :commentable do
      resources :answers, except: %i[new show]
    end

    resources :answers, except: %i[new show], concerns: :commentable

    namespace :admin do
      resources :users, only: %i[index create edit update destroy]
    end

    root 'pages#index'
  end
end
