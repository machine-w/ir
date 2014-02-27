InstitutionalRepos::Application.routes.draw do
  get "users/index"
  devise_for :users, :path => "account"
  root :to => "home#index"
  
  
  # WARRING! 请保持 User 的 routes 在所有路由的最后，以便于可以让用户名在根目录下面使用，而又不影响到其他的 routes
  # 比如 http://localhost/huacnlee
  #get "users/city/:id" => "users#city", as: 'location_users'
  #get "users" => "users#index", as: 'users'
  shallow do  
    resources :users, :path => "",:only => :show do
      member do
        get :admin
      end
      resources :folders do
        resources :properties
        resources :documents do
          resources :attritubes
        end
      end
      namespace 'admin' do
        resources :folders do
          resources :properties
          resources :documents do
            resources :attritubes
          end
        end
      end
    end
  end
end
