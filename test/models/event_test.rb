require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "#created_by? owner_idと引数の#idが同じ時" do
    event = FactoryBot.create(:event)
    user = User.new
    # Eventモデルのテストなので、Userモデルのオブジェクトを使ってテストをすると、Userモデルの実装に依存したテストになるので、スタブ化したオブジェクトを使用し、それぞれの結合を疎にする

    # 上で生成したuserオブジェクトをスタブ化し、idメソッドの戻り値をevent.owner_idに変更(この変更はブロック間のみ有効)
    user.stub(:id, event.owner_id) do
      # スタブ化されたuserオブジェクトでテスト
      assert_equal(true, event.created_by?(user))
    end
  end

  test "#created_by? owner_idと引数の#idが異なる時" do
    event = FactoryBot.create(:event)
    another_user = User.new
    # event.owner_id に +1 することで違うidをしてさせた
    another_user.stub(:id, event.owner_id + 1) do
      assert_equal(false, event.created_by?(another_user))
    end
  end

  test "#created_by? 引数がnilの時" do
    event = FactoryBot.create(:event)
    assert_equal(false, event.created_by?(nil))
  end
end
