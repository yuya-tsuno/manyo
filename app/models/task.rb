class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #TODO 後ほどuser_idにpresence: trueを追加します。
end
