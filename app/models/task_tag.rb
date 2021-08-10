class TaskTag < ApplicationRecord
  belongs_to :tag
  belongs_to :task
end
