module ApplicationHelper
  def filter_plain_text_with_attachments(text)
    text.gsub(/\[.*?\]/, '').strip
  end
end
