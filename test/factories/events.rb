FactoryBot.define do
  factory :event do
    # 関連名を書くと同名の定義を自動で利用する(レコードを作成すると、onwer_idとして、あわせて作成されるUserのidが設定される)
    owner
    sequence(:name) { |i| "イベント名#{i}"}
    sequence(:place) { |i| "イベント開催場所#{i}"}
    sequence(:content) { |i| "イベント本文#{i}"}
    start_at { rand(1..30).days.from_now}
    end_at { start_at + rand(1..30).hours}
  end
end
