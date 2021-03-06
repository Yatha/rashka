Rashka::Application.routes.draw do

  post "admin/login"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  match 'admin' => 'admin#index', via: :get

  resources :news

  resources :reasons do
    collection do
      get 'get_one_random'
      get 'get_three_random'
    end
  end

  match 'stats' => 'stats#index', via: :get
  match 'stats/evacuate' => 'stats#evacuate', via: :post
  match 'stats/vk_post' => 'stats#vk_post', via: :post
  match 'stats/fb_post' => 'stats#fb_post', via: :post
  match 'stats/tw_post' => 'stats#tw_post', via: :post
  match 'stats/bl_post' => 'stats#bl_post', via: :post

  #match 'news/index' => 'news#index_admin', via: :get

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
