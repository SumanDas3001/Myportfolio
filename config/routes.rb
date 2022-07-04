Rails.application.routes.draw do
  resources :topics
  resources :comments

  devise_for :users, path: "", controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: "sessions", registrations: "registrations", confirmations: 'confirmations' }, path_names: { sign_in: 'login', password: 'forgot', confirmation: 'confirm', unlock: 'unblock', sign_up: 'register', sign_out: 'signout'}
  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  resources :own_portfolios, except: [:show] do
    put :sort, on: :collection
  end
  get 'angular-items', to: 'own_portfolios#angular'
  get 'portfolio/:id', to: 'own_portfolios#show', as: 'portfolio_show' # custom portfolio show path
  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  post 'contact_us', to: 'pages#contact_us'
  post 'tech-news', to: 'pages#tech_news'
  resources :blogs do
    member do
      get :toggle_status # This routes is for draft or published post
      get :favorite_unfavorite_blog
    end
  end
  mount ActionCable.server => '/cable'
  root "pages#home"
end
