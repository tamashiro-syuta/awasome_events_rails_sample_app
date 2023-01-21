class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def show
    @event = Event.find(params[:id])
    # includes(:user)は、Tickets取得時に関連するUserオブジェクトを一度に取得する。使わないと@ticketsの要素の数だけSQLクエリが発行されてしまう(N+1問題)
    # https://pikawaka.com/rails/includes <-- わかりやすかった記事
    @tickets = @event.tickets.includes(:user).order(:created_at)
    # ログイン済みのユーザーがいて、ユーザーのチケットに今表示中のチケットがあれば、それを@ticketに入れる
    @ticket = current_user && current_user.tickets.find_by(event: @event)
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: "作成しました"
    end
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "更新しました"
    end
  end

  def destroy
    @event = current_user.created_events.find(params[:id])
    # 「!」をつけることで何らかの理由で削除に失敗した場合、例外処理が走るので、エラーをキャッチできる
    # 「!」なしだと、失敗した場合はfalseが返る
    @event.destroy!
    redirect_to root_path, notice: "削除しました"
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :content, :start_at, :end_at, :image, :remove_image
    )
  end

end
