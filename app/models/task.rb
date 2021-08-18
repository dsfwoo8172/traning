class Task < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  after_update_commit {broadcast_replace_to "tasks"}
  after_destroy_commit {broadcast_remove_to "tasks"}
  
  validates_presence_of :title, :start_time, :end_time, :priority, :state
  
  scope :with_state, -> (state){ where(state: state) if state }
  scope :with_priority, -> (priority){ where(priority: priority) if priority }
  scope :with_keyword, -> (keyword){ where('title ILIKE ?', "%#{keyword}%") if keyword }
  scope :reorder_by_sort, ->(sort) { reorder(sort) if sort }
  
  enum priority: { low: 0, middle: 1, high: 2 }
  enum state: { pending: 0, proccesing: 1, finished: 2 }

  # 可以用 Post.tagge_with(tagname) 來找到文章
  def self.tagged_with(name)
    return all if name.blank?

    Tag.where(name: name).first.tasks
  end

  # # 如果要取用 tag_list，可以加上這個 getter
  def tag_list
    tags.map(&:name)
  end

  # # tag_list 的 setter
  def tag_list=(names)
    self.tags = names.map { |item|
      Tag.where(name: item.strip).first_or_create! unless item.blank?
    }.compact!
  end
end
