class NestedSubjectAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      subject = []
      if v.include?('subject') and not v['subject'].blank? and not v['subject'][0].blank?
        subject << link_to(ERB::Util.h(v['subject'][0]), search_path(v['subject'][0]))
      end
      # if v.include?('subject_scheme') and not v['subject_scheme'].blank? and not v['subject_scheme'][0].blank?
      #   subject << "Subject Scheme: #{v['subject_scheme'][0]}"
      # end
      # if v.include?('scheme_uri') and not v['scheme_uri'].blank? and not v['scheme_uri'][0].blank?
      #   subject << "Scheme URI: #{link_to(ERB::Util.h(v['scheme_uri'][0]), search_path(v['scheme_uri'][0]))}"
      # end
      # if v.include?('value_uri') and not v['value_uri'].blank? and not v['value_uri'][0].blank?
      #   subject << "Value URI: #{link_to(ERB::Util.h(v['value_uri'][0]), search_path(v['value_uri'][0]))}"
      # end
      html << subject.join('<br>')
    end
    html = html.join('<br/>')
    %(#{html})
  end
end
