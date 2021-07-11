class Task < ApplicationRecord
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :priority
  validates_presence_of :state
  default_scope {order(created_at: :desc)} # 預設以創建時間排序

  enum priority: { low: 0, middle: 1, high: 2 }
  enum state: { pending: 0, proccesing: 1, finished: 2 }
end
