class HomeController < ApplicationController
  include Pagy::Backend

  def index
    @q = Article.ransack(params[:q])
    @pagy, @articles = pagy(@q.result.top)
  end

  def search
    @pagy, @articles = pagy(Article._search(params[:text]).top)
  end
end
