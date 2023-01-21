class WelcomeController < ApplicationController
  # authenticateをスキップ(ログイン状態でなくても、このcontrollerの処理は行える)
  skip_before_action :authenticate

  def index
    @events = Event.page(params[:page]).per(5).
      where("start_at > ?", Time.zone.now).order(:start_at)

    puts "@events"
    puts @events
  end
end
