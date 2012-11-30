module ApplicationHelper

  def full_title(page_title)
    base_title = "Demo"
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end
end
