class RetirementsController < ApplicationController
  def new
  end

  def create
    if current_user.destroy
      # セッションも削除し、ログアウト後と同じ状態にする
      reset_session
      redirect_to root_path, notice: "退会完了しました"
    end
  end
end
