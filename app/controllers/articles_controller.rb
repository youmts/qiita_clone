class ArticlesController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :current_user_is_owner!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @article = @user.articles.build
  end

  def edit
  end

  def create
    @article = @user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to [@user, @article], notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to [@user, @article], notice: 'Article was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Article was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end
    def current_user_is_owner!
      # show 404 page
      raise ActiveRecord::RecordNotFound if current_user != @user
    end
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :user_id)
    end
end
