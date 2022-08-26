Rails.application.routes.draw do
  root "customers#index"
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    passwords: 'public/passwords',
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root :to => 'homes#top'
    # address
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    # customer
    get 'customers/my_page' => 'customers#show'
    get 'customers/my_page/edit' => 'customers#edit'
    patch 'customers/my_page/complete' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    # ゲストログイン
    devise_scope :customer do
     post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
    end

    # item
    resources :items, only:[:index, :show] do
      resource :favorites, only:[:create, :destroy]
      collection do
        get "genre_search" => "items#genre_search"
        get "/item_search" => "items#item_search"
      end
    end
    # cart_items
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index, :update, :destroy, :create]
    # orders
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only:[:new, :create, :index, :show]
  end

  namespace :admin do
    get "" => "homes#top"
    resources :customers, only:[:index, :show, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :update, :edit]
    resources :orders, only:[:show, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :order_details, only:[:update]
  end

end
