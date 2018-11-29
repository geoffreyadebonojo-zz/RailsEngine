Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :invoice_items, only: [:index, :show]
      resources :customers, only: [:index, :show]
      
      namespace :merchants do
        get '/random', to: 'merchant_search#show'
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'

        get '/most_revenue', to: 'merchant_intelligence#show'
      end
      resources :items, only: [:index, :show]
      
      # TODO determine nesting
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :show]
        resources :invoices, only: [:index, :show]  
      end 

      resources :transactions, only: [:index, :show]
    end
  end
end
