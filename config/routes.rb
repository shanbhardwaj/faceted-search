Blog::Application.routes.draw do
  get "retailers/index"

  resources :retailer_ledgers

  resources :wines do
  	collection do
  		get 'hsearch'
      get 'hsearch_drpdwn'
  	end
  end
  resources :retailers, :only => [:index]

  resources :comments

  resources :articles
  root :to => "articles#index"
end
