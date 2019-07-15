class TagsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @tags = pagy(ActsAsTaggableOn::Tag.order(taggings_count: :desc))
  end
end
