class HomeController < ApplicationController
  include Pagy::Backend

  def trend
    @pagy, @articles = pagy_array(Article.trend(1.months, 100))
  end

  def tag_feed
    @pagy, @articles = pagy(Article.top)
  end
end
