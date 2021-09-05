Rails.application.routes.draw do
  root "patients#index"

  resources :patients, only: %i[index] do
    resources :notes, only: %i[index new create show]
  end
end
