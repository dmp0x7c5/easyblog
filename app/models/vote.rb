class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  after_save :update_comment

  field :value, type: Integer

  validates_presence_of :value, :user, :comment
  # Fantastic feature below:
  validates_uniqueness_of :user, scope: :comment

  belongs_to :user
  belongs_to :comment

  def update_comment
    if comment.dislikes == 3
      comment.abusive = true
      comment.save
    end
  end

end
