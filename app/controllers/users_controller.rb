class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show; end

  private

  def set_user
    @user = User.includes(:posts).find(params[:id])
  end
end
