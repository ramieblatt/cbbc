Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
