class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.save!

    ArticlesMailer.with(user: current_user, comment: @comment)
  end

  def destroy
    # TODO current_user.comments...
    @comment = @article.comments.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @comment.user == current_user
    @comment.destroy!
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      # TODO make cool
      p = params.require(:comment).permit(:body)
      p[:user] = current_user
      p
    end
end
