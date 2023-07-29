module Api
  module V1
    class PostsController < ApplicationController
      def index
        @user = User.find(params[:user_id])
        @posts = @user.posts
        render json: @posts, status: :ok
      end
    end
  end
end
