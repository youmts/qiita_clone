class HomeController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @articles = pagy(Article.top)
  end

  def search
    @pagy, @articles = pagy(Article.search(params[:text]).top)
  end
end
