class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  scope :nonabusive, -> { where(abusive: false) }

  validates_presence_of :user_id
# rspec uses empty body and post_id
# validates_presence_of :body, :post_id, :user_id

  belongs_to :user
  belongs_to :post

  has_many :votes

  def likes
    count(1)
  end

  def dislikes
    count(-1)
  end

  private

  def count(what)
    count = 0
    votes.each { |v|
      count += 1 if v.value == what
    }
    count
  end

end
