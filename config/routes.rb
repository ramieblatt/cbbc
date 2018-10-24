Rails.application.routes.draw do
  devise_for :users
  mount Lockup::Engine, at: '/lockup'
  constraints(subdomain: 'admin') do
    resources :cards
    resources :players do
      collection do
        get :prebuilt_search
        post :prebuilt_search
      end
    end
    resources :editions do
      collection do
        post :create_cards_from_players
      end
      member do
        post :create_cards
        delete :remove_all_cards
      end
    end
    root to: 'players#index'
  end
  constraints(subdomain: 'api') do
    scope :cards, format: :json do
      scope ':token_id' do
        get '/', to: 'cards#show_by_token_id'
      end
    end
  end
  constraints( ->(request) { request.subdomain.blank? or request.subdomain =="www" }) do
    resources :cards
    root to: 'cards#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
