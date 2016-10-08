class CommentsController < ApplicationController

  def new

  end

  def show
    @comment = Comment.find(params[:id])
  end


  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      render :new
    end
  end

  def upvote
    comment = Comment.find(params[:id])
    comment.upvote
    redirect_to post_url(comment.post)
  end

  def downvote
    comment = Comment.find(params[:id])
    comment.downvote
    redirect_to post_url(comment.post)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
