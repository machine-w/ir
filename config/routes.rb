InstitutionalRepos::Application.routes.draw do
  get "discipline/:id" => "discipline#show"
  get "department/:id" => "department#show"
  #post ":user_id/search"  => "search#index"
  post ":user_id/admin/search" => "admin/search#index"
  post "fixview/pubu"
  post "fixview/fixheader"
  #get "upload/serve"
  get "/upload/grid/*path" => "upload#serve"
  # get "documents/create"
  # get "properties/create"
  get "users/index"
  devise_for :users, :path => "account", :controllers => { registrations: :registrations,sessions: :sessions }
  root :to => "home#index"
  
  
  # WARRING! 请保持 User 的 routes 在所有路由的最后，以便于可以让用户名在根目录下面使用，而又不影响到其他的 routes
  # 比如 http://localhost/huacnlee
  #get "users/city/:id" => "users#city", as: 'location_users'
  #get "users" => "users#index", as: 'users'
  #shallow do  
    resources :users, :path => "",:only => :show,:constraints => lambda{|req| !(req.original_url =~ /.*websocket$/) } do
      member do
        get :admin
      end
      resources :folders, only: [:index, :new, :create] do
        collection do
          get :shared
        end
      end 
      namespace 'admin' do
        resources :folders, only: [:index, :new, :create]
        resources :contacts, only: [:index, :new, :create] do
          collection do
            get :users_not_firend,:users_in_firend,:discipline_not_firend,:department_not_firend
          end
        end
        resources :notifications, only: [:index, :new, :create] do
          collection do
            get :read_all
          end
        end
        resources :groups, only: [:index, :new, :create] do
          collection do
            get :read_all
          end
        end
        resources :todolists
      end
      resources :conversations do
        collection do
          get :read_all
        end
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
            get :children_folder,:config_property,:config_doc_view,:config_static_properties,:config_permission,:config_share_permission,:config_share_property
            put :update_doc_view,:update_static_properties,:update_permission,:update_share_permission
          end
          resources :properties do
            member do
              put :update_share
            end
          end
          resources :documents, only: [:index, :new, :create] do
            collection do
              get :children_folder
              post :copy_document
            end
          end
      end
      resources :documents, only: [:show, :edit, :update, :destroy] do
          resources :attritubes
          member do
           patch :config_permission,:config_parent_visiable
           get :permission_model
          end
      end
      resources :contacts, only: [:show, :edit, :update, :destroy]
      resources :notifications, only: [:show, :edit, :update, :destroy]
      resources :groups, only: [:show, :edit, :update, :destroy] do
         member do
           post :add_member,:del_member,:modify_member,:sign_out,:add_message
         end
      end
    end
  #end
end
