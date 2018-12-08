Rails.application.routes.draw do
  get 'quotes/:tag_search', to: 'quotes#search', as: :quotes_search
  resources :authentications, only: %i[create index]
end
