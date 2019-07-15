class TagsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: [:add, :remove]
  before_action :set_tag, only: [:add, :remove]

  def index
    @pagy, @tags = pagy(ActsAsTaggableOn::Tag.order(taggings_count: :desc))
  end

  def add
    current_user.tags << @tag unless current_user.tags.exists?(@tag.id)
  end

  def remove
    current_user.tags.destroy(@tag)
  end

  private
    def set_tag
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
    end
end
