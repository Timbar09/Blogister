class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_and_user, only: %i[index new create destroy]
  
  def index
    @comments = @post.comments
    render json: @comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    if @comment.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: user_post_path(@user, @post), notice: 'Comment was successfully created.') }
        format.json { render json: @comment, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, alert: 'Error: Comment was not created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_back(fallback_location: user_post_path(@user, @post), notice: 'Comment was successfully deleted.')
    else
      render :show, alert: 'Comment was not deleted.'
    end
  end

  private

  def set_post_and_user
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
