class LikesController < ApplicationController
  def create
    @like = Like.new
    @post = Post.find(params[:post_id])
    @like.post = @post
    @like.author = current_user

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Like was successfully created.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Like was not created.'
    end
  end
end
