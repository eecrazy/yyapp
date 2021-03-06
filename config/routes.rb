Yyapp::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main_pages#home'

  match '/like', to: 'likes#toggle', via: 'post'
  match '/hate', to: 'hates#toggle', via: 'post'
  match '/sign', to: 'main_pages#sign', via:'get'
  match '/guess', to: 'main_pages#guess', via:'get'
  match '/search', to: 'searchs#index', via:'get'
  
  devise_for :users ,:path => "users", :controllers => {
    :registrations => :users,
    :sessions => :sessions,
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  devise_scope :user do
    get "users/:id" => "users#show"
    get "users" => "users#index"
    match '/users/destroy/:id', to: 'users#cancel', as: "destroy_user", via: "delete"
  end

  resources :users

  delete "user/auth/:provider/unbind" => "users#auth_unbind", as: 'unbind_account'
  get 'tags/:tag', to: 'apps#index', as: :tag
  
  match '/tag_it', to: 'apps#tag_it',  via: "post"
  resources :apps do
    resources :comments , :only => [:create]
    resources :images , :only => [:create,:destroy]
  end

  
  resources :images
  
  #match '/images', to: 'images#create', via:'post'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
