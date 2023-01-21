class ApplicationController < ActionController::Base
  before_action :authenticate
  # controllerとviewの両方から呼ばれる機会があるので、helper_methodでメソッド名を宣言
  # logged_in?メソッドとcurrent_userをヘルパーメソッドとして使うよの宣言
  helper_method :logged_in?, :current_user

  # rescueは、後ろに登録したものから順番に判定されるため、Exceptionは一番上に定義している
  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

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
    redirect_to root_path, alert: "ログインしてください"
  end

  def error404(e)
    render "error404", status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join("\n")
    render "error500", status: 500, formats: [:html]
  end
end
