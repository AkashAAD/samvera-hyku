class DatasetSizeAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    %(<span itemprop="size"><a href="Size:#{value}">#{value}</a></span>)
  end
end