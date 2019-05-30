class NestedDescriptionAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbody>'
    value.each do |v|
      description_type = ''
      description = ''
      if v.include?('description_type') and not v['description_type'].blank? and
        not v['description_type'][0].blank?
        description_type = "Description Type: #{v['description_type'][0]}"
      end
      if v.include?('description') and not v['description'].blank? and not v['description'][0].blank?
        description = "Description: #{v['description'][0]}"
      end
      html += "<tr><th>#{description_type}</th><td>#{description}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
