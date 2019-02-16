Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    omniauth_callbacks: 'overrides/omniauth_callbacks'
  }

  scope module: 'api' do
    namespace :v1 do
      resources :users, only: %i[index show], path: 'user' do
        collection do
          get 'current'
          get 'facebook_pages'

          resources :bots do
            get 'bot_sessions'
            get 'recipient_info'

            put 'subscribe'
            put 'configure_persistent_menu'

            delete 'delete_persistent_menu'

            resources :flows do
              resources :states do
                resources :quick_replies
              end
            end
          end
        end
      end
    end
  end

  mount Facebook::Messenger::Server, at: 'bot'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
