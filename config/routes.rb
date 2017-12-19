Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions"}
  # eg. http://localhost:3000/admins/sign_in
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions"}
  # eg. http://localhost:3000/users/sign_in
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
