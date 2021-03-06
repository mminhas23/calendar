Calendar::Application.routes.draw do
  devise_for :users

  resources :user , :controller => 'user'
  match '/user', :to => 'user#create', :as => "create_user", :via => "put"
  match '/students/batches/:id', :controller => 'students', :action => 'batches', :format => 'js'
  match '/students/courses/:id', :controller => 'students', :action => 'courses', :format => 'js', :via => "get"

  resources :home, :only => :index
  resources :batches do
    get 'withdraw', :on => :member
  end
  resources :categories
  resources :courses do
    get 'enroll', :on => :member
    get 'assign', :on => :member
    get 'batches', :on => :member
    post 'student', :on => :member
  end
  resources :students do
    resources :comments
    get 'assign', :on => :member
  end
  resources :time_tables
  resources :tutors
  resources :days
  resources :slots
  resources :descriptions

  root :to =>"home#index"
  get "home/index"
end
