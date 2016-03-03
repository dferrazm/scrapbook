Rails.application.routes.draw do
  defaults format: 'json' do
    namespace :api do
      namespace :v1 do
        resources :users, except: [:new, :edit]
      end
    end
  end
end
