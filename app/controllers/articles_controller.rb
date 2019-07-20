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

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_path, notice: 'Article was successfully destroyed.' }
    end
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
