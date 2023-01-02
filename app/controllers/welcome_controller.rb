class WelcomeController < ApplicationController
  # authenticateをスキップ(ログイン状態でなくても、このcontrollerの処理は行える)
  skip_before_action :authenticate
  def index
  end
end
