Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'bookings/:id/confirm', to: 'bookings#confirm'
    end
  end
end
