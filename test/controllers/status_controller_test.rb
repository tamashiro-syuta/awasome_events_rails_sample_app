require 'test_helper'

class StatusControllerTest < ActionDispatch::IntegrationTest
  test "GET /status" do
    get "/status"

    # レスポンスのステータスコードを確認
    assert_response(:success)
    # レスポンスのJSONが一致しているか確認
    assert_equal({status: "ok"}.to_json, @response.body)
    # レスポンスのMIMEタイプがapplication/typeか確認
    assert_equal("application/json", @response.media_type)
  end
end
