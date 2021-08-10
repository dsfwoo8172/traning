class Task < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  

  validates_presence_of :title, :start_time, :end_time, :priority, :state
  scope :with_tag_and_without_keyword, -> (tag, options){ tagged_with(tag).or(without_keyword(options)) }
  scope :with_tag_and_with_keyword, -> (tag, options){ tagged_with(search_params[:tag]).or(@tasks.with_keyword(options)) }
  scope :without_keyword, -> (options){ where('priority = ? or state = ?', Task.priorities[options[:priority]], Task.states[options[:state]]) }
  scope :with_keyword, -> (options){ where('title like ? or priority = ? or state = ?', "%#{options[:keyword]}%", Task.priorities[options[:priority]], Task.states[options[:state]])}
  
  enum priority: { low: 0, middle: 1, high: 2 }
  enum state: { pending: 0, proccesing: 1, finished: 2 }

  # 可以用 Post.tagge_with(tagname) 來找到文章
  def self.tagged_with(name)
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
