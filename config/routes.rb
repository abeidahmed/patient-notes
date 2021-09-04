Rails.application.routes.draw do
  resources :patients, only: [] do
    resources :notes, only: %i[new create]
  end
end
