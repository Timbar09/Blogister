class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = Like.find_by(author: current_user, post: @post)

    if @like
      if @like.destroy
      redirect_back(fallback_location: user_post_path(@post.author, @post), notice: 'You successfully unliked the post.')
      else
        redirect_back(fallback_location: user_post_path(@post.author, @post), alert: 'Error: Could not unlike the post.')
      end
    else
      @like = Like.new(author: current_user, post: @post)

      if @like.save
        redirect_back(fallback_location: user_post_path(@post.author, @post), notice: 'You successfully liked the post.')
      else
        redirect_back(fallback_location: user_post_path(@post.author, @post), alert: 'Error: Could not like the post.')
      end
    end
  end
end
