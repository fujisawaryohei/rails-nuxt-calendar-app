class Todo < ApplicationRecord
  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true
  validates :date, presence: true
  validates :time, presence: true
end
