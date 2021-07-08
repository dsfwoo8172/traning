class Task < ApplicationRecord
  belongs_to :user
  # validates :title, :start_time, :end_time, :priority, :state, presence: { message: '不能空白'}
  validates_presence_of :title
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :priority
  validates_presence_of :state

  enum priority: { low: 0, middle: 1, high: 2 }
  enum state: { pending: 0, proccesing: 1, finished: 2 }
end
