class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)

    @comment.save!
  end

  def destroy
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      p = params.require(:comment).permit(:body)
      p[:user] = current_user
      p
    end
end
