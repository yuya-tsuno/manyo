class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #TODO 後ほどuser_idにpresence: trueを追加します。

  enum priority: {
    高: 0,
    中: 1,
    低: 2
  }

  def self.search(search_title, search_status)
    if search_title || search_status
      Task.where(['title LIKE ?', "%#{search_title}%"]).where(['status LIKE ?', "%#{search_status}%"])
    else
      Task.all
    end
  end

end
