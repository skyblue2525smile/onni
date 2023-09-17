Rails.application.routes.draw do
  scope module: :public do
    #「scope module」を使用することで、呼び出すコントローラのアクションのみグループ化

    root to: 'homes#top'
    resource :homes, only: [] do
      get :about
      get :introduction
    end
      # [id]が必要な時は、[resources]でまとめる
      # [id]が不要な時は、[resource]でまとめる

    resources :items, only: %i(index show)

    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        post :confirm
        get :thanks
      end
      # [id]が必要な時は、[member]で囲む
      # [id]が不要な時は、[collection]で囲む
    end

    resources :cart_items, only: [:index, :create, :edit, :update, :destroy] do
      collection do
        delete :destroy_all
        # 注意！ [destroy_all]は[id]が不要！
      end
    end

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

    resource :customer, only: [] do
      get :my_page
      get :confirm
      patch :withdrawal
      # 注意！ 今回、[show]アクションを[my_page]に書き換えているので、view名も[my_page]にする
      # 豆知識 もし同じレイアウトのviewを複数のアクションで使用する場合は、[render :対象のview名]にする
      # 注意！ [withdrawal]は[id]が不要！
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
