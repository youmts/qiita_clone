class HomeController < ApplicationController
  def index
    @articles = Article.top(10)
  end
end
