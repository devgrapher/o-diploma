Rails.application.routes.draw do
  root "diplomas#index"

  get "/diplomas", to: "diplomas#index"
  get "/diplomas/search", to: "diplomas#search"
  get "/diplomas/:id", to: "diplomas#show", as: :diploma

end
