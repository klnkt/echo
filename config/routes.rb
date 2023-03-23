Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  root to: redirect('/api-docs')

  mount API::Root => '/'
end
