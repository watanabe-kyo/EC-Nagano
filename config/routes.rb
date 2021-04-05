Rails.application.routes.draw do
  devise_for :admin, controllers: {
  	sessions: 'admin/sessions',
  	registrations: 'admin/registrations',
  	passwords: 'admin/passwords'
  }
  devise_for :customers, controllers: {
  	sessions: 'public/sessions',
  	registrations: 'public/registrations',
  	passwords: 'public/passwords'
  }

  namespace :admin do
  	root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end
  end

  scope module: :public do
  	root to: "homes#top"
    get 'about' => "homes#about"
    resource :customer, only: [:show, :edit, :update]
    get 'customers/unsubscribe' => "customers#unsubscribe"
    patch 'customers/withdraw' => "customers#withdraw"
    resources :items, only: [:index, :show]
    delete 'cart_items/destroy_all' => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    post 'orders/confirm' => "orders#confirm"
    get 'orders/thanks' => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
