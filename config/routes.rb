Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :confirmation, :withdrawal]
    resources :cart_items, only: [:index, :update, :destroy, :all_destroy, :create]
    resources :orders, only: [:new, :information, :complete, :show, :create, :index]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
   
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get '' => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:show, :update]
    resources :orders, only: [:update]
  end
end
