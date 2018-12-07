Rails.application.routes.draw do
  resources :authentications, only: %i(create index)
end
