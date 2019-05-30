class NestedIdentifierAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbody>'
    value.each do |v|
      date = ''
      date_type = ''
      date_information = ''
      if v.include?('date') and not v['date'].blank? and
        not v['date'][0].blank?
        label = v['date'][0]
      end
      if v.include?('date_type') and not v['date_type'].blank? and not v['date_type'][0].blank?
        date_type = v['date_type'][0]
      end
      if v.include?('date_information') and not v['date_information'].blank? and not v['date_information'][0].blank?
        date_information = v['date_information'][0]
      end      
      html += "<tr><th>#{label}</th><td>#{val}</td><td>#{date_information}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
