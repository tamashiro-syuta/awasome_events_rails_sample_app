class User < ApplicationRecord
  # ユーザーが作成したイベントだと理解しやすいように、created_eventsという名前で定義(通常なら、モデル名であるeventにする)
  # モデル名と異なる関連付けを追加したので、オプションのclass_nameで、どのクラスと紐つけるのか指定
  # 外部キーも、デフォルトのuser_idでないカラムと紐つけるので、オプションのforeign_keyで、紐付けるカラムを指定
  has_many :created_events, class_name: "Event", foreign_key: "owner_id"
  has_many :tickets

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    # find_or_create_by : 引数に設定した値(ここではproviderとuid)に一致するレコードがない場合は、作成
    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end
end
