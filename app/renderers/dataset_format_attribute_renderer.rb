class DatasetFormatAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    %(<span itemprop="format"><a href="Format: #{value}">#{value}</a></span>)
  end
end