class Todo < ApplicationRecord
  validates :title, presence: true, length: { maximum: 4 }
  validates :content, presence: true
  validates :date, presence: true
end
