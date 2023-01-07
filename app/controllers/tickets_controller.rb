class TicketsController < ApplicationController
  def new
    # ユーザーが直接URLを入力した時にルーティングエラーにする
    # ※未ログイン時は、beforeのauthenticateメソッドで先にログインさせる挙動なので本来はこのメソッドが呼ばれることはない
    raise ActionController::RoutingError, "ログイン状態でTicketController#newにアクセス"
  end

  def create
    puts "params"
    puts params
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end
    if @ticket.save
      redirect_to event, notice: "このイベントに参加表明しました"
    end
  end
end
