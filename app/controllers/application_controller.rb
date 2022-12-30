class ApplicationController < ActionController::Base
  # controllerとviewの両方から呼ばれる機会があるので、helper_methodでメソッド名を宣言
  # logged_in?メソッドをヘルパーメソッドとして使うよの宣言
  helper_method :logged_in?

  private

  # ログイン状態を返すメソッドで、アクションではないのでprivateに定義する
  def logged_in?
    # 「!」を前につけるのはnot演算子,2つ連続で重ねることでsession[:user_id]がfalse or nilの時はfalse、それ以外はtrueを返す
    !!session[:user_id]
  end
end
