class PublicationYearAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    %(<span itemprop="telephone"><a href="Year:#{value}">#{value}</a></span>)
  end
end