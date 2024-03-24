module PostsHelper
  def status_label(status)
    status_generator status
  end

  private

  def status_generator(status)
    case status
    when 'submitted'
      content_tag(:span, status.titleize, class: 'd-inline p-2 text-bg-primary')
    when 'approved'
      content_tag(:span, status.titleize, class: 'd-inline p-2 text-bg-success')
    when 'rejected'
      content_tag(:span, status.titleize, class: 'd-inline p-2 text-bg-danger')
    end
  end
end
