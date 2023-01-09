require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  test "/ ページを表示" do
    # root_urlに遷移(GETメソッドを投げている)
    visit root_url

    # h1タグの文言が指定のものかテスト
    assert_selector "h1", text: "イベント一覧"
  end
end
