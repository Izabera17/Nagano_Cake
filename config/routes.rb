Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"

  scope module: :public do
    get 'about' => 'homes#about'
    resources :items, only:[:index,:show,:new] do
        get :search, on: :collection # ジャンル検索機能用
    end
    resource :customers, only: [:show ,:edit,:update]
    get "customers/confirmation" => "customers#confirmation"
    patch "customers/withdrawal" => "customers#withdrawal"

    resources :items, only: [:index, :show] do
      get :search, on: :collection # ジャンル検索機能用
    end
    post 'items' => 'orders#information'

    resources :cart_items do
     collection do
        delete 'destroy_all'
      end
    end
    
    resources :orders, only: [:new, :show, :create, :index]
    post 'orders/information' => 'orders#information'
    get 'orders/complete' => 'orders#complete'

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get '' => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:show, :update]
    resources :orders, only: [:update]
  end

end