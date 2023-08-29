Rails.application.routes.draw do


  scope module: :public do
    #「scope module」を使用することで、呼び出すコントローラのアクションのみグループ化

    root to: "/" => 'homes#top'
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

    get "/customers/my_page" => "customers#show"
    get "/customers/edit/information" => "customers#edit"
    # 「customers/edit」にするとdeviseのルーティングと被るため、「information」を付け加えている
    patch "/customers/information" => "customers#update"
    get "/customers/confirm" => "customers#confirm"
    patch "/customers/:id/withdrawal" => "customers#withdrawal"
    end
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "/admin" => 'homes#top'
    resources :items
    resources :customers, onky: [:index, :show, :edit, :update]
    resources :orders, only: [:update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
