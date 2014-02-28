BpmSales::Engine.routes.draw do
  resources :invoices do
    member do
      put 'mark_paid'
    end
    resources :line_items
  end
  get "report/index"
  get "panel/index"
  resources :customers
  root to: "panel#index"
end
