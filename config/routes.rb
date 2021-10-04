Rails.application.routes.draw do
  root "diplomas#index"

  get 'diplomas/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
