Rails.application.routes.draw do
  post "/auth/login", to: "auth#login"

  namespace :recruiter do
    resources :recruiters
    resources :jobs
    resources :submissions
  end
end
