class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
