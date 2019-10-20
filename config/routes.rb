Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:show, :create, :destroy]
      
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :albums, only: [:index]
        resources :comments, only: [:index]
        resources :conversations, only: [:index]
        resources :events, only: [:index]
        resources :friendships, only: [:index]
        resources :images, only: [:index]
        resources :likes, only: [:index]
        resources :messages, only: [:index]
        resources :posts, only: [:index]
        resources :relationships, only: [:index]
      end

      resources :albums, only: [:show, :create, :update, :destroy] do
        resources :images, only: [:index]
      end

      resources :comments, only: [:create, :update, :destroy]

      resources :conversations, only: [:show, :create, :update, :destroy] do
        resources :messages, only: [:index]
      end

      resources :events, only: [:show, :create, :update, :destroy] do
        resources :comments, only: [:index]
        resources :event_invites, only: [:index]
      end

      resources :event_invites, only: [:show, :create, :update, :destroy]

      resources :friendships, only: [:create, :update, :destroy]

      resources :images, only: [:show, :create, :update, :destroy] do
        resources :comments, only: [:index]
        resources :likes, only: [:index]
      end

      resources :likes, only: [:show, :create, :update, :destroy]

      resources :messages, only: [:show, :create, :update, :destroy]

      resources :posts, only: [:show, :create, :update, :destroy] do
        resources :comments, only: [:index]
        resources :images, only: [:index]
        resources :likes, only: [:index]
      end

      resources :relationships, only: [:create, :update, :destroy]
    end
  end
end
