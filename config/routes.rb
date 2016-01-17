Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    match '/register-your-email/:id' => 'omniauth_callbacks#register_email', via: [:get, :patch], as: :register_user_email
  end

  resources :products
  root 'products#index'
end
