Rails.application.routes.draw do
  root "diplomas#search_form"

  get "/diplomas", to: "diplomas#index"
  get "/diplomas/search", to: "diplomas#search_form"
  post "/diplomas/search", to: "diplomas#search"
  get "/diplomas/:id", to: "diplomas#show", as: :diploma

end
