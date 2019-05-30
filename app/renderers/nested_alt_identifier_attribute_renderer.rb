# class NestedAltIdentifierAttributeRenderer < Hyrax::Renderers::AttributeRenderer
#   private
#   def attribute_value_to_html(value)
#     value = JSON.parse(value)
#     if not value.kind_of?(Array)
#       value = [value]
#     end
#     html = '<table class="table"><tbodby>'
#     value.each do |v|
#       alt_identifier = ''
#       alternate_identifier_type = ''
#       if v.include?('alt_identifier') and not v['alt_identifier'].blank? and not v['alt_identifier'][0].blank?
#         alt_identifier =  v['alt_identifier'][0]
#       end
#       if v.include?('alternate_identifier_type') and not v['alternate_identifier_type'].blank? and not v['alternate_identifier_type'][0].blank?
#         alternate_identifier_type = v['alternate_identifier_type'][0]
#       end
#       html += "<tr><th>#{alt_identifier}</th><td>#{alternate_identifier_type}</td></tr>"
#     end
#     html += '</tbody></table>'
#     %(#{html})
#   end
# end
