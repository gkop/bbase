module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require "redcarpet"

  def render(text)
    html = Redcarpet.new(text).to_html
    insert_captions(html)
  end

  private
  def insert_captions(html)
    parsed = Nokogiri::HTML::DocumentFragment.parse(html)
    parsed.css("img[title]").each do |img|
      title = img['title']
      title_inner_html = Redcarpet.new(img['title']).to_html
      title_content =  Nokogiri.parse(title_inner_html).children[0]
      span = Nokogiri::XML::Node.new "span", parsed
      span.children = title_content.children
      span.set_attribute("class", "image-caption")
      img.add_next_sibling(span)
      title.tr!('*', '"')
      img["title"] = img["alt"] = title
    end
    parsed.to_s.html_safe
  end
end
