Blog::Application.routes.draw do
  resources :retailer_ledgers

  resources :wines

  resources :comments

  resources :articles
  root :to => "articles#index"
end
