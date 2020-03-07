class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :user_id, presence: true

  belongs_to :user

  enum priority: { high: 0, middle: 1, low: 2 }
  enum status: { not_started_yet: 0, started: 1, completed: 2 }

  #Todo scopeを用いて書き換え、検索と並び替えを同時に実行できるようにする。
  def self.search(search_title, search_status, current_user_id)
    if search_title.blank? && search_status.blank?
      Task.where('user_id = ?', current_user_id)
    elsif search_title && search_status.blank?
      Task.where('title LIKE ?', "%#{search_title}%").where('user_id = ?', current_user_id)
    elsif search_title.blank? && search_status
      Task.where('status = ?', search_status).where('user_id = ?', current_user_id)
    else
      Task.where(['title LIKE ?', "%#{search_title}%"]).where(['status = ?', search_status]).where('user_id = ?', current_user_id)
    end
  end

  def self.search_for_admin(search_title, search_status)
    if search_title.blank? && search_status.blank?
      Task.select(:id, :title, :limit, :priority, :created_at, :user_id)
    elsif search_title && search_status.blank?
      Task.where('title LIKE ?', "%#{search_title}%").select(:id, :title, :limit, :priority, :created_at, :user_id)
    elsif search_title.blank? && search_status
      Task.where('status = ?', search_status).select(:id, :title, :limit, :priority, :created_at, :user_id)
    else
      Task.where(['title LIKE ?', "%#{search_title}%"]).where(['status = ?', search_status]).select(:id, :title, :limit, :priority, :created_at, :user_id)
    end
  end
  
end