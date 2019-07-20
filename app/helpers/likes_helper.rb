module LikesHelper
  def likes_link_to(article)
    return unless current_user
    if current_user.voted_up_on? article
      return link_to content_tag(:i, "いいね済み", class: "fa fa-check"),
                     unlike_article_path(article), method: :delete, remote: true
    else
      return link_to content_tag(:i, "いいね", class: "fa fa-thumbs-up"),
                     like_article_path(article), method: :post, remote: true
    end
  end
end