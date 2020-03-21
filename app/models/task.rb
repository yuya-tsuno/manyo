class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :user_id, presence: true

  belongs_to :user, optional: true

  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  # has_many :labeling_labels, through: :labelings, source: :label

  enum priority: { high: 0, middle: 1, low: 2 }
  enum status: { not_started_yet: 0, started: 1, completed: 2 }

  scope :kaminari, -> { page(params[:page]).per(5) }

  scope :order_by_created_at, -> { order(created_at: :desc) }
  scope :order_by_limit, -> { order(limit: :asc) }
  scope :order_by_priority, -> { order(priority: :asc) }

  scope :search_with_current_user, -> (current_user) { where user_id: current_user.id}
  scope :search_with_title, -> (search_title) { where('title LIKE ?', "%#{search_title}%") if name.present? }
  scope :search_with_status, -> (search_status) { where('status LIKE ?', "%#{search_status}%") if name.present? }
  scope :search_with_label, -> (search_label) { where label: search_label if search_label.present? }

  # #Todo scopeを用いて書き換え、検索と並び替えを同時に実行できるようにする。
  # def self.search(search_title, search_status, current_user_id)
  #   if search_title.blank? && search_status.blank?
  #     Task.where('user_id = ?', current_user_id)
  #   elsif search_title && search_status.blank?
  #     Task.where('title LIKE ?', "%#{search_title}%").where('user_id = ?', current_user_id)
  #   elsif search_title.blank? && search_status
  #     Task.where('status = ?', search_status).where('user_id = ?', current_user_id)
  #   else
  #     Task.where(['title LIKE ?', "%#{search_title}%"]).where(['status = ?', search_status]).where('user_id = ?', current_user_id)
  #   end
  # end

  # def self.search_for_admin(search_title, search_status)
  #   if search_title.blank? && search_status.blank?
  #     Task.select(:id, :title, :limit, :priority, :created_at, :user_id)
  #   elsif search_title && search_status.blank?
  #     Task.where('title LIKE ?', "%#{search_title}%").select(:id, :title, :limit, :priority, :created_at, :user_id)
  #   elsif search_title.blank? && search_status
  #     Task.where('status = ?', search_status).select(:id, :title, :limit, :priority, :created_at, :user_id)
  #   else
  #     Task.where(['title LIKE ?', "%#{search_title}%"]).where(['status = ?', search_status]).select(:id, :title, :limit, :priority, :created_at, :user_id)
  #   end
  # end
  
end