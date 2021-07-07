class Task < ApplicationRecord
  belongs_to :user
  validates :title, :start_time, :end_time, presence: { message: '不能空白'}

  ORDER = ['low', 'middle', 'high']
  STATE = ['pending', 'proccesing', 'finished']
end
