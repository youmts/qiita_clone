class HomeController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @articles = pagy(Article.top)
  end
end
