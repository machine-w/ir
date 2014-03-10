InstitutionalRepos::Application.routes.draw do
  get "users/index"
  devise_for :users, :path => "account"
  root :to => "home#index"
  
  
  # WARRING! 请保持 User 的 routes 在所有路由的最后，以便于可以让用户名在根目录下面使用，而又不影响到其他的 routes
  # 比如 http://localhost/huacnlee
  #get "users/city/:id" => "users#city", as: 'location_users'
  #get "users" => "users#index", as: 'users'
  #shallow do  
    resources :users, :path => "",:only => :show do
      member do
        get :admin
      end
      resources :folders, only: [:index, :new, :create]
      namespace 'admin' do
        resources :folders, only: [:index, :new, :create]
      end
    end


    resources :folders, only: [:show, :edit, :update, :destroy] do
      resources :properties
      resources :documents, only: [:index, :new, :create]
    end
    resources :documents, only: [:show, :edit, :update, :destroy] do
      resources :attritubes
    end
    #######
    namespace 'admin' do
      resources :folders, only: [:show, :edit, :update, :destroy] do
          member do
            get :config_property
          end
          resources :properties
          resources :documents, only: [:index, :new, :create]
      end
      resources :documents, only: [:show, :edit, :update, :destroy] do
          resources :attritubes
      end
    end
  #end
end
