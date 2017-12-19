Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions"}
  # eg. http://localhost:3000/admins/sign_in
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions"}
  # eg. http://localhost:3000/users/sign_in



  devise_scope :user do
    authenticated :user do
      root 'users/users#index', as: :authenticated_root
    end

    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end

  devise_scope :admin do
    authenticated :admin do
      root 'admins/admins#index', as: :admin_authenticated_root
    end

    unauthenticated do
      root 'admins/sessions#new', as: :admin_unauthenticated_root
    end
  end

  root 'users/users#index'

  get    '/users(.:format)',           to: 'users/users#index'
  post   '/users(.:format)',           to: 'users/users#create'
  get    '/users/new(.:format)',       to: 'users/users#new',              as: :new_user
  get    '/users/:id/edit(.:format)',  to: 'users/users#edit',             as: :edit_user
  get    '/users/:id(.:format)',       to: 'users/users#show',             as: :user
  patch  '/users/:id(.:format)',       to: 'users/users#update'
  put    '/users/:id(.:format)',       to: 'users/users#update'
  delete '/users/:id(.:format)',       to: 'users/users#destroy'

  get    '/admins(.:format)',           to: 'admins/admins#index'
  post   '/admins(.:format)',           to: 'admins/admins#create'
  get    '/admins/new(.:format)',       to: 'admins/admins#new',              as: :new_admin
  get    '/admins/:id/edit(.:format)',  to: 'admins/admins#edit',             as: :edit_admin
  get    '/admins/:id(.:format)',       to: 'admins/admins#show',             as: :admin
  patch  '/admins/:id(.:format)',       to: 'admins/admins#update'
  put    '/admins/:id(.:format)',       to: 'admins/admins#update'
  delete '/admins/:id(.:format)',       to: 'admins/admins#destroy'
end
