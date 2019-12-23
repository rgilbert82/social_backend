Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :comments, only: [:create, :update, :destroy]

      resources :conversations, only: [:show, :create, :update]

      resources :events, only: [:show, :create, :update, :destroy] do
        resources :event_invites, only: [:index]
      end

      resources :event_invites, only: [:show, :create, :update, :destroy]

      post 'friendship_confirm/:id', to: 'friendships#confirm', as: 'friendship_confirm'
      post 'friendship_deny/:id',    to: 'friendships#deny',    as: 'friendship_deny'
      post 'friendship_status/:id',  to: 'friendships#status',  as: 'friendship_status'

      post 'like_status/:id',  to: 'likes#status',  as: 'like_status'

      resources :messages, only: [:create]

      resources :posts, only: [:create, :update, :destroy]

      resources :sessions, only: [:show, :create, :destroy]

      resources :users, only: [:index, :show, :create, :update, :destroy] do
        get 'inbox',  to: 'conversations#inbox',  as: 'inbox'
        get 'trash',  to: 'conversations#trash',  as: 'trash'
        resources :events, only: [:index]
        resources :posts, only: [:index]
      end
    end
  end
end
