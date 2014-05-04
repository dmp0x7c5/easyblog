class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_path(@post)
  end

  def vote_up
    vote 1
  end

  def vote_down
    vote -1
  end

  def mark_as_not_abusive
    @comment = Comment.find(params[:id])
    @comment.abusive = false
    @comment.save
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
      params.require(:comment).permit(:body)
  end

  def vote(value)
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.create(value: value, user: current_user,
				  comment: @comment)
    if @vote.save
      flash[:notice] = 'Vote saved'
    else
      flash[:alert] = 'Current user has already voted'
    end
    redirect_to post_path(params[:post_id])
  end

end
