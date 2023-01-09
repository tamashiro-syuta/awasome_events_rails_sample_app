require "test_helper"

# ここにシステムテストの設定を記述
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  # これでログイン用のヘルパーが使えるようになる
  include SignInHelper
end
