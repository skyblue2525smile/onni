Rails.application.routes.draw do
  scope module: :public do
    #「scope module」を使用することで、呼び出すコントローラのアクションのみグループ化

    root to: 'homes#top'
    resource :homes, only: [] do
      get :about
      get :introduction
    end

    resources :items, only: %i(index show)

    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        post :confirm
        get :thanks
      end
    end

    resources :cart_items, only: [:index, :create, :edit, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

    resource :customer, only: [] do
      get :my_page
      get :confirm
      patch :withdrawal
    end
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

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # 権限/コントローラ名/アクション

end
