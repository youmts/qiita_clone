class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def like
    current_user.likes @article
    render 'reload'
  end

  def unlike
    current_user.unlike @article
    render 'reload'
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
end
