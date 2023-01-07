class User < ApplicationRecord
  # 削除前にバリデーションを走らせる
  before_destroy :check_all_events_finished

  # ユーザーが作成したイベントだと理解しやすいように、created_eventsという名前で定義(通常なら、モデル名であるeventにする)
  # モデル名と異なる関連付けを追加したので、オプションのclass_nameで、どのクラスと紐つけるのか指定
  # 外部キーも、デフォルトのuser_idでないカラムと紐つけるので、オプションのforeign_keyで、紐付けるカラムを指定
  # dependent: :nullify は、削除時に関連するレコードの外部キーをnullにする
  has_many :created_events, class_name: "Event", foreign_key: "owner_id", dependent: :nullify
  has_many :tickets, dependent: :nullify
  # check_all_events_finishedメソッドの中で、参加しているイベントを調べるために、participating_eventsを定義
  has_many :participating_events, through: :tickets, source: :event

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

  private

  def check_all_events_finished
    now = Time.zone.now
    if created_events.where(":now < end_at", now: now).exists?
      errors[:base] << "公開中の未終了イベントが存在します。"
    end

    if participating_events.where(":now < end_at", now: now).exists?
      errors[:base] << "未終了の参加イベントが存在します。"
    end

    throw(:abort) unless errors.empty?
  end
end
