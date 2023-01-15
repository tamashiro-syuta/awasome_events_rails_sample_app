require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "#created_by? owner_idと引数の#idが同じ時(スタブver)" do
    event = FactoryBot.create(:event)
    user = User.new
    # Eventモデルのテストなので、Userモデルのオブジェクトを使ってテストをすると、Userモデルの実装に依存したテストになるので、スタブ化したオブジェクトを使用し、それぞれの結合を疎にする

    # 上で生成したuserオブジェクトをスタブ化し、idメソッドの戻り値をevent.owner_idに変更(この変更はブロック間のみ有効)
    user.stub(:id, event.owner_id) do
      # スタブ化されたuserオブジェクトでテスト
      assert_equal(true, event.created_by?(user))
    end
  end

  test "#created_by? owner_idと引数の#idが同じ時(モックver)" do
    event = FactoryBot.create(:event)
    # モックは、戻り値の変更に加えて、そのメソッド(下ではidメソッドが呼ばれる)が呼び出されたかを確認できる(user.verify)

    # idにevent.owner_idを返すモックを生成し、userに格納(user.id = 1 になる)
    user = MiniTest::Mock.new.expect(:id, event.owner_id)
    assert_equal(true, event.created_by?(user))
    # モックオブジェクトのidメソッドが呼び出されたかを確認(これがないとエラーになる)
    user.verify
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

  test 'start_at_should_be_before_end_at validation OK' do
    start_at = rand(1..30).days.from_now
    end_at = start_at + rand(1..30).hours
    # buildは、保存していない状態のオブジェクトを作る
    event = FactoryBot.build(:event,
                            start_at: start_at, end_at: end_at)
    # バリデーションを実行
    event.valid?
    # event.errors[:start_at]が空(= バリデーションにかかっていない)を確認(event.errorsとはなく、カラムを指定することで、特定のカラムのテストであることを保証している)
    assert_empty(event.errors[:start_at])
  end

  test 'start_at_should_be_before_end_at validation error' do
    start_at = rand(1..30).days.from_now
    end_at = start_at - rand(1..30).hours
    event = FactoryBot.build(:event,
                            start_at: start_at, end_at: end_at)
    event.valid?
    # event.errors[:start_at]が空じゃない(= バリデーションにかかっている)を確認
    assert_not_empty(event.errors[:start_at])
  end
end
