Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'
  resources :cards
  resources :players
  resources :editions do
    member do
      post :create_cards
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
