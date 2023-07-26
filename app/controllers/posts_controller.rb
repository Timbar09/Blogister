class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show]
  before_action :set_user, only: %i[index show new]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comments = @post.comments.includes(:author)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new, alert: 'Post was not created.'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.includes(:comments).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
