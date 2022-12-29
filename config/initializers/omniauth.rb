Rails.application.config.middleware.use OmniAuth::Builder do
  # 学習用のアプリなので、環境変数を変えずに同じものを使用
  if Rails.env.development? || Rails.env.test?
    provider :github,
    Rails.application.credentials.github[:client_id],
    Rails.application.credentials.github[:client_secret]
  else
    provider :github,
    Rails.application.credentials.github[:client_id],
    Rails.application.credentials.github[:client_secret]
  end
end
