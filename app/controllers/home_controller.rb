class HomeController < ApplicationController
  include Pagy::Backend

  def trend
    @pagy, @articles = pagy(Article.top)
  end

  def tag_feed
    @pagy, @articles = pagy(Article.top)
  end
end
