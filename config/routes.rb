Rails.application.routes.draw do
  namespace :accounts do
	  resources :users, only: [:create, :show]
  end

  namespace :wallet do
    resources :users, only: [] do
      resources :customer_transactions, only: [:create]
    end
  end

  namespace :benefits do
    resources :users, only: [] do
      resources :rewards, only: [:index]
    end
  end
end
