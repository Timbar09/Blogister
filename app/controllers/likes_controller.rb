class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = Like.find_by(author: current_user, post: @post)

    if @like
      @like.destroy
      redirect_back(fallback_location: user_post_path(@post.author, @post), notice: 'Post was successfully unliked.')
    else
      @like = Like.new(author: current_user, post: @post)

      if @like.save
        redirect_back(fallback_location: user_post_path(@post.author, @post), notice: 'Post was successfully liked.')
      else
        redirect_back(fallback_location: user_post_path(@post.author, @post), alert: 'Error: Post was not liked.')
      end
    end
  end
end
