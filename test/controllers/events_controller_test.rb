require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "自分で作ったイベントは削除できる" do
    event_owner = FactoryBot.create(:user)
    event = FactoryBot.create(:event, owner: event_owner)
    sign_in_as event_owner
    assert_difference("Event.count", -1) do
      delete event_url(event)
    end
  end

  test "他の人が作ったイベントは削除できない" do
    event_owner = FactoryBot.create(:user)
    event = FactoryBot.create(:event, owner: event_owner)
    sign_in_user = FactoryBot.create(:user)
    sign_in_as sign_in_user
    # DELETEのリクエストを送っても、イベントの数は変わらない(= 削除できない)
    assert_difference("Event.count", 0) do
      # ブロックで指定した動作(DELETEのリクエストを送る)を行うと、引数に指定した例外をキャッチする
      assert_raises(ActiveRecord::RecordNotFound)do
        delete event_url(event)
      end
    end
  end
end
