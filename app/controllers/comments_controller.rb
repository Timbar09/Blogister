class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_and_user, only: %i[new create destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    p @comment

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      render :new, alert: 'Comment was not created.'
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
