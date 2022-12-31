class Event < ApplicationRecord
  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  varidates :start_at, presence: true
  varidates :end_at, presence: true
  # メソッドもバリデーションできる
  validates :start_at_should_be_before_end_at

  private

  # start_atはend_atよりも前の時間
  def start_at_should_be_before_end_at
    return unless start_at && end_at
    if start_at >= end_at
      errors.add(:start_at, "は終了時間よりも前に設定してください")
    end
  end
end
