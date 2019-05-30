class NestedRightsAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbodby>'
    value.each do |v|
      rights = ''
      rights_uri = ''
      if v.include?('rights') and not v['rights'].blank? and not v['rights'][0].blank?
        rights =  "Rights: #{v['rights'][0]}"
      end
      if v.include?('rights_uri') and not v['rights_uri'].blank? and not v['rights_uri'][0].blank?
        rights_uri = "Rights URI: #{v['rights_uri'][0]}"
      end
      html += "<tr><th>#{rights}</th><td>#{rights_uri}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
