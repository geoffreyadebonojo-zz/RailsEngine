Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do

      namespace :invoice_items do
        get '/random', to: 'invoice_item_random#show'        
        get '/find', to: 'invoice_item_search#show'
        get '/find_all', to: 'invoice_item_search#index'
      end
      
      
      namespace :invoices do
        get '/random', to: 'invoice_random#show'        
        get '/find', to: 'invoice_search#show'
        get '/find_all', to: 'invoice_search#index'
        
      end
      
      
      namespace :customers do
        get '/random', to: 'customer_random#show'
        get '/find', to: 'customer_search#show'
        get '/find_all', to: 'customer_search#index'
      end
      
      
      namespace :merchants do
        get '/random', to: 'merchant_random#show'
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'
        get '/most_revenue', to: 'merchant_intelligence#show'
      end
      
      
      namespace :items do
        get '/random', to: 'item_random#show'        
        get '/find', to: 'item_search#show'
        get '/find_all', to: 'item_search#index'
      end
      
      
      namespace :transactions do
        get '/random', to: 'transaction_random#show'
        get '/find', to: 'transaction_search#show'
        get '/find_all', to: 'transaction_search#index'
      end


      resources :invoice_items, only: [:index, :show] do
        get '/item', to: 'invoice_items/item#show'
        get '/invoice', to: 'invoice_items/invoice#show'
      end

      resources :customers, only: [:index, :show] do 
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        resources :merchants, only: [:index]        
      end

      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        
        get '/customer', to: 'invoices/customer#show'
        get '/merchant', to: 'invoices/merchant#show'
      end


      
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      resources :transactions, only: [:index, :show] do 
        resources :invoices, only: [:index]
      end
    end
  end
end
