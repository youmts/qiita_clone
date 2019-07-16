class TagsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    @pagy, @tags = pagy(ActsAsTaggableOn::Tag.order(taggings_count: :desc))
  end

  def create
    @tag = set_tag(params[:tag_id])
    current_user.tags << @tag unless current_user.tags.exists?(@tag.id)
    render 'reload_row'
  end

  def destroy
    @tag = set_tag(params[:id])
    current_user.tags.destroy(@tag)
    render 'reload_row'
  end

  private
    def set_tag(id)
      @tag = ActsAsTaggableOn::Tag.find(id)
    end
end
