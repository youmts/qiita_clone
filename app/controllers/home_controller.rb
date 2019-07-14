class HomeController < ApplicationController
  def index
    @articles = Article.top(10)
  end

  def search
    @articles = Article.search(params[:text]).top(10)
  end
end
