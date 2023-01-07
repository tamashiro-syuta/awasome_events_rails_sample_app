class WelcomeController < ApplicationController
  # authenticateをスキップ(ログイン状態でなくても、このcontrollerの処理は行える)
  skip_before_action :authenticate

  def index
    @events = Event.where("start_at > ?", Time.zone.now).order(:start_at)
  end
end
