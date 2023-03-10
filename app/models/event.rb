class Event < ApplicationRecord
  # [has_one_attached :image] これでeventとactive storageがimageというカラムで繋がる
  # [dependent: false]イベントが削除された時に関連するActiveStorage::Attachmentのみが削除される
  has_one_attached :image, dependent: false
  has_many :tickets, dependent: :destroy
  belongs_to :owner, class_name: "User"

  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :image,
    # 画像の形式を限定
    content_type: [:png, :jpg, :jpeg],
    # 10mb以上はNG
    size: { less_than_or_equal_to: 10.megabytes },
    # 縦 or 横 が2000以上はNG
    dimension: { width: { max: 2000 }, height: { max:2000 } }
  # validatesは標準のバリデーション、validateは独自のバリデーションメソッド
  validate :start_at_should_be_before_end_at

  # 画像削除の際の属性'remove_image'は、独自で定義したものなので、明示的にmodelで定義する必要がある
  attr_accessor :remove_image

  # 保存前にremove_image_if_user_acceptを行うコールバックを設定
  before_save :remove_image_if_user_accept

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end

  private

  # remove_imageがtrue(チェック済み)であればimageカラムをnilに設定
  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end

  # start_atはend_atよりも前の時間
  def start_at_should_be_before_end_at
    return unless start_at && end_at
    if start_at >= end_at
      errors.add(:start_at, "は終了時間よりも前に設定してください")
    end
  end
end
