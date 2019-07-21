module ApplicationHelper
  def log_in_required(message, &block)
    if current_user
      capture(&block)
    else
      link_to message, new_user_session_url
    end
  end
end
