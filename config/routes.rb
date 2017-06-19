Rails.application.routes.draw do
  #get 'admin/index'

  #get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users do
    resources :journals
  end
  controller :journals do 
    get 'journalsearch' => 'journals#journalsearchprint'
    post 'journalsearch' => :journalsearch
  end
  root 'admin#index'

  get 'admin' => 'admin#index'
  controller :sessions do 	
  	get 'login' => :new
  	post 'login' => :create
  	delete 'logout' => :destroy
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
