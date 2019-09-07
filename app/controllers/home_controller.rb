class HomeController < ApplicationController
  include Pagy::Backend

  def trend
    @pagy, @articles = pagy(Article.top)
  end
end
