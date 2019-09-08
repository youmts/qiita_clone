module ApplicationHelper
  def log_in_required(message, &block)
    if current_user
      capture(&block)
    else
      link_to message, new_user_session_url
    end
  end

  def side_links(paths)
    tag.div class: "list-group" do
      paths.map do |path|
        active = current_page?(path[1]) ? "active" : nil
        link_to path[0], path[1],
          class: "list-group-item list-group-item-action #{active}"
      end.join.html_safe
    end
  end
end
