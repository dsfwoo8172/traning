class Task < ApplicationRecord
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :priority
  validates_presence_of :state

  scope :without_keyword, -> (options){ where(options)}
  scope :with_keyword, -> (options){ where('title like ? or priority = ? or state = ?', "%#{options[:keyword]}%", Task.priorities[options[:priority]], Task.states[options[:state]])}
  
  enum priority: { low: 0, middle: 1, high: 2 }
  enum state: { pending: 0, ㄉproccesing: 1, finished: 2 }
end
