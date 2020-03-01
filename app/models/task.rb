class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #TODO 後ほどuser_idにpresence: trueを追加します。

  enum priority: {
    high: 0,
    middle: 1,
    low: 2
  }
end
