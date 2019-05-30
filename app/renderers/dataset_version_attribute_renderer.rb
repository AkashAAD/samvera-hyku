class DatasetVersionAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    %(<span itemprop="version"><a href="Version:#{value}">#{value}</a></span>)
  end
end