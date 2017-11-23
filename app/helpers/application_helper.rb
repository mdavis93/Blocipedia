module ApplicationHelper

  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true),
                no_intra_emphasis: true,
                fenced_code_blocks: true,
                autolink: false,
                disable_indented_code_blocks: true,
                strikethrough: true)

    return markdown.render(text).html_safe
  end
end
