class HomeController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @articles = pagy(Article.favorite(current_user).top)
  end

  def search
    @pagy, @articles = pagy(Article.search(params[:text]).top)
  end
end
