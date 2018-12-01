Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do

      namespace :invoice_items do
        get '/find', to: 'invoice_item_search#show'
      end
      resources :invoice_items, only: [:index, :show]


      namespace :invoices do
        get '/find', to: 'invoice_search#show'
      end
      resources :invoices, only: [:index, :show]


      namespace :customers do
        get '/find', to: 'customer_search#show'
      end
      resources :customers, only: [:index, :show]
      

      namespace :merchants do
        get '/random', to: 'merchant_random#show'
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'
        get '/most_revenue', to: 'merchant_intelligence#show'
      end
      resources :merchants, only: [:index, :show]


      namespace :items do
        get '/find', to: 'item_search#show'
      end
      resources :items, only: [:index, :show]

      
      namespace :transactions do
        get '/find', to: 'transaction_search#show'
      end
      resources :transactions, only: [:index, :show]

    end
  end
end
