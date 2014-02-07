BpmSales::Engine.routes.draw do
  get "report/index"
  get "panel/index"
  resources :customers
  root to: "panel#index"
end
