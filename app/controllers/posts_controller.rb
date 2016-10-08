class PostsController < ApplicationController

  before_action :check_author, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      redirect_to new_sub_post_url(params[:sub_id])
    end
  end

  def index
    @posts = Post.all
  end

  def edit
    @subs = Sub.all
  end

  def update
    @post.update(post_params)
    redirect_to post_url(@post)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments_by_parent = @post.comments_by_parent_id
  end

   def upvote
    post = Post.find(params[:id])
    post.upvote
    redirect_to request.referrer
  end

  def downvote
    post = Post.find(params[:id])
    post.downvote
    redirect_to request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end

   def check_author
    @post = Post.find(params[:id])
    unless current_user.id == @post.author_id
      redirect_to root_url
    end
  end
end
