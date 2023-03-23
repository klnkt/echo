Rails.application.routes.draw do
  root to: redirect('/docs')

  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  mount API => '/'
end
