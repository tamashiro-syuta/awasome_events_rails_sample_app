Rails.application.routes.draw do
  root 'welcome#index'

  # ログイン後のcallback先とアクションを紐付ける
  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"
end
