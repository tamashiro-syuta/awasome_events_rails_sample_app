FactoryBot.define do
  # factoryメソッドは、第1引数にテストケースから呼び出される名称を書く
  # ケースによってはownerという名で呼ばれることもあるため、aliseを設定
  factory :user, aliases: [:owner] do
    # attribute名 {"値"} でテストデータの属性を指定
    provider { "github" }
    # sequenceでは、ユニーク制約などで固定値を回避するために使う(テストごとに違う値になる)
    sequence(:uid) { |i| "uid#{i}"}
    sequence(:name) { |i| "name#{i}"}
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg"}
  end
end
