class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.article = @article

    if @comment.save
      render
    else
      render 'error'
    end
  end

  def destroy
    @comment = current_user.comments.where(article: @article).find(params[:id])
    @comment.destroy!
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
