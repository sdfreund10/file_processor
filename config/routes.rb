Rails.application.routes.draw do
  root to: "data_files#index"
  resources :processors
  resources :data_files do
    member do
      get :download_original
      get :download_processed
      put :process_file
    end
  end
end
