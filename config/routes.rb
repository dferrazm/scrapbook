Rails.application.routes.draw do
  defaults format: 'json' do
    namespace :api do
      namespace :v1 do
        resources :users, except: [:new, :edit] do
          resources :scrapnotes, only: [:create, :update, :destroy]
        end
        resources :scrapnotes, only: [:index, :show]
        resources :moods, except: [:new, :edit]
      end
    end
  end
end
