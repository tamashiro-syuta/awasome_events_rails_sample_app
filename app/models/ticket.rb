class Ticket < ApplicationRecord
  # モデル側でもuserのnullを許容
  belongs_to :user, optional: true
  belongs_to :event

  # コメントの文字数はMAX30文字（但し、空白もOK）
  validates :comment, length: { maximum: 30 }, allow_blank: true
end
