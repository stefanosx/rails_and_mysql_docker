Rails.application.routes.draw do

  resources :tasks

  get 'tasks/auto_complete_search'

  root to: 'task/#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
