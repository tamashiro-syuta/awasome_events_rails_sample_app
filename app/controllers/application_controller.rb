class ApplicationController < ActionController::Base
  before_action :authenticate
  # controllerとviewの両方から呼ばれる機会があるので、helper_methodでメソッド名を宣言
  # logged_in?メソッドとcurrent_userをヘルパーメソッドとして使うよの宣言
  helper_method :logged_in?, :current_user

  private

  # ログイン状態を返すメソッドで、アクションではないのでprivateに定義する
  def logged_in?
    # 「!」を前につけるのはnot演算子,2つ連続で重ねることでsession[:user_id]がfalse or nilの時はfalse、それ以外はtrueを返す
    !!current_user
  end

  def current_user
    # ログイン状態でない場合に早期リターンさせる
    return unless session[:user_id]
    # @current_userに値が入っていなければ、インスタンス変数にログインしているユーザーを入れる
    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: "ログインしていください"
  end
end
