ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html_doc = Nokogiri::HTML::DocumentFragment.parse(html_tag, Encoding::UTF_8.to_s)
  element = html_doc.children[0]

  if element
      element.add_class('is-invalid')

      if %w[input select textarea].include? element.name
          element.add_next_sibling "<div class=\"invalid-feedback\">#{[*instance.error_message].join(",<br>")}.</div>"
          instance.raw html_doc.to_html
      else
          instance.raw html_doc.to_html
      end
  else
      html_tag
  end
end
