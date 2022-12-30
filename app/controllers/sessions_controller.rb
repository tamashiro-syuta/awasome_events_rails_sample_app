class SessionsController < ApplicationController
  def create
    # request.env["omniauth.auth"]というOmniAuth::AuthHashオブジェクトをを利用する
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました"
  end

  def destroy
    # セッションの初期化
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end
