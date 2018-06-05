Rails.application.routes.draw do

  scope module: :private, constraints: ApiAccess.new('private', false) do
    get 'locations/:provider_id', to: 'locations#index'
    get 'target_groups/:provider_id', to: 'target_groups#index'
    post 'country/:country_code/price', to: 'pricing#index'
  end

  scope module: :public, constraints: ApiAccess.new('public', true) do
    get 'locations/:provider_id', to: 'locations#index'
    get 'target_groups/:provider_id', to: 'target_groups#index'
  end

  post 'auth/login', to: 'authentication#authenticate'

end
