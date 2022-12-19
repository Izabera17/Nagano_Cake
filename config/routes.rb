Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"

  scope module: :public do
    get 'about' => 'homes#about'
    resources :items, only:[:index,:show,:new] do
        get :search, on: :collection
    end

    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    get "customers/confirmation" => "customers#confirmation"
    patch "customers/withdrawal" => "customers#withdrawal"
    patch "customers/information" => "customers#update"

    resources :cart_items do
     collection do
        delete 'destroy_all'
      end
    end

    get "orders/complete" => "orders#complete"
    post "orders/information" => "orders#information"
    
    resources :orders, only: [:new, :create, :index, :show]

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get '' => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:update]
    resources :orders, only: [:update, :show]
  end

end