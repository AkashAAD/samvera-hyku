class NestedReviewersAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbodby>'
    value.each do |v|
      if v.include?('reviewer') and not v['reviewer'].blank? and not v['reviewer'][0].blank?
        user = User.find_by_id(v['reviewer'][0])
        html += "<tr><th>#{user.email}</th><td>#{user.display_name}</td></tr>"
      end
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
