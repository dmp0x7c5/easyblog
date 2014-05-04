class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user

  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
    hot = 0
    if created_at >= 1.day.ago
      hot = 3
    elsif created_at < 1.day.ago and created_at >= 3.days.ago
      hot = 2
    elsif created_at < 3.days.ago and created_at >= 7.days.ago
      hot = 1
    end
    if comments.count() >= 3
      hot += 1
    end
    hot
  end

end
