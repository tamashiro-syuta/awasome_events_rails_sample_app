module SignInHelper
  # sign_in_asは、ログイン用のヘルパーメソッド（引数のオブジェクトでログインする機能を提供）
  def sign_in_as(user)
    # 以下の2行でOmniAuthをモック化し、テスト用の挙動に差し替えている
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { nickname: user.name, image: user.image_url }
    )

    case
    when respond_to?(:visit)
      # root_urlに遷移
      visit root_url
      # ログインのボタンをクリック(内部では、上でモック化した内容(add_mockメソッドの内容)が返ってきている)
      click_on "GitHubでログイン"
    when respond_to?(:get)
      get "/auth/github/callback"
    else
      raise NotImplementedError.new
    end
    @current_user = user
  end

  def current_user
    @current_user
  end
end

# インテフレーションテストでもログイン処理のヘルパーを使えるようにinclude
class ActionDispatch::IntegrationTest
  include SignInHelper
end
