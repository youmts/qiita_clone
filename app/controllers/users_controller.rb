class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    gon.tags_count = @user.articles_tags_count.to_a
  end
end
