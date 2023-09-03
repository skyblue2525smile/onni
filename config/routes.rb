Rails.application.routes.draw do


  scope module: :public do
    #「scope module」を使用することで、呼び出すコントローラのアクションのみグループ化

    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"
    get "/homes/introduction" => "homes#introduction", as: "introduction"

    resources :items, only: [:index, :show]

    resources :orders, only: [:new, :index, :show, :create] do
      post 'confirm' => "orders#confirm"
      get 'thanks' => "orders#thanks"
    end

    resources :cart_items, only: [:index, :create, :edit, :update, :destroy] do
      delete 'destroy_all' => "cart_items#destroy_all"
    end

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

    get "/customer/my_page" => "customers#show"
    get "/customer/edit/information" => "customers#edit"
    # 「customers/edit」にするとdeviseのルーティングと被るため、「information」を付け加えている
    patch "/customer/information" => "customers#update"
    get "/customer/confirm" => "customers#confirm"
    patch "/customer/:id/withdrawal" => "customers#withdrawal"
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, path: :customer, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, path: :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers, only: [:index, :show, :edit, :update] do
      resources :orders, only: [:index, :show, :update]
      resources :order_details, only: [:update]
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
