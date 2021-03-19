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
  end

  scope module: :public do
  	root to: "homes#top"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
