class Task < ApplicationRecord
  validates :title, presence: true
  validates :email, uniqueness: true
  validates :content, presence: true
  #TODO 後ほどuser_idにpresence: trueを追加します。

  enum priority: { high: 0, middle: 1, low: 2 }
  enum status: { not_started_yet: 0, started: 1, completed: 2 }

  def self.search(search_title, search_status)
    if search_title.blank? && search_status.blank?
      Task.all
    elsif search_title && search_status.blank?
      Task.where('title LIKE ?', "%#{search_title}%")
    elsif search_title.blank? && search_status
      Task.where('status = ?', search_status)
    else
      Task.where(['title LIKE ?', "%#{search_title}%"]).where(['status = ?', search_status])
    end
  end
  
end