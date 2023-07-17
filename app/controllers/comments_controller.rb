class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params.merge(author: current_user))

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      render :new, alert: 'Comment was not created.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
