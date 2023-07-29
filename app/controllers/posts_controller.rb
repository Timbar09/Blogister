class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show destroy]
  before_action :set_user, only: %i[index show new destroy destroy]

  def index
    @posts = @user.posts.includes(:comments)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
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

  def destroy
    if @post.destroy
      redirect_back(fallback_location: user_posts_path(current_user), notice: 'Post was successfully deleted.')
    else
      render :show, alert: 'Post was not deleted.'
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
