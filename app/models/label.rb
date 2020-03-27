class Label < ApplicationRecord
  validates :name, presence: true

  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
  # has_many :labeling_tasks, through: :labelings, source: :task
end
