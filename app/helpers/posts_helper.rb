module PostsHelper
  def status_label(status)
    status_generator status
  end

  private

  def status_generator(status)
    case status
    when 'submitted'
      content_tag(:span, status.titleize, class: 'badge text-bg-primary')
    when 'approved'
      content_tag(:span, status.titleize, class: 'badge text-bg-success')
    when 'rejected'
      content_tag(:span, status.titleize, class: 'badge text-bg-danger')
    end
  end
end
