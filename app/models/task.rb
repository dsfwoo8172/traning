class Task < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates_presence_of :title, :start_time, :end_time, :priority, :state

  scope :without_keyword, -> (options){ where(options)}
  scope :with_keyword, -> (options){ where('title like ? or priority = ? or state = ?', "%#{options[:keyword]}%", Task.priorities[options[:priority]], Task.states[options[:state]])}
  
  enum priority: { low: 0, middle: 1, high: 2 }
  enum state: { pending: 0, proccesing: 1, finished: 2 }
end
