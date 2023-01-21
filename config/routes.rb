Rails.application.routes.draw do
  root 'welcome#index'
  # ログイン後のcallback先とアクションを紐付ける
  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resource :retirements, only: %i[new create]

  # ネストにすることでリソースの親子関係をルーティングで表現
  resources :events do
    resources :tickets
  end

  get "status" => 'status#index', defaults: { format: 'json' }

  # routes.rbに定義されていないURLへのリクエストは、RackMiddleWareで発生するので、コントローラーレベルで定義しているrescue_fromではキャッチできない
  # なので、以下で全てのURLをキャッチする設定を追加(知らないURLは404用ページへルーティング)
  match "*path" => "application#error404", via: :all
end
