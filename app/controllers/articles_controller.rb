class ArticlesController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article_owner, only: [:edit, :update, :destroy]

  def index
    @q = Article.ransack(params[:q])
    @pagy, @articles = pagy(@q.result.top)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  private
    def set_article_owner
      @article = current_user.articles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :tag_list, :body)
    end
end
