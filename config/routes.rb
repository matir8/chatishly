Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    omniauth_callbacks: 'overrides/omniauth_callbacks'
  }

  scope module: 'api' do
    namespace :v1 do
      resources :users, only: %i[index show] do
        collection do
          get 'current'
          get 'facebook_pages'
        end
      end
    end
  end

  mount Facebook::Messenger::Server, at: 'bot'
end
