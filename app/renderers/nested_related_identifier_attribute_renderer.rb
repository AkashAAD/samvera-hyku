class NestedRelatedIdentifierAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbodby>'
    value.each do |v|
      rel_identifier = []
      if v.include?('related_identifier') and not v['related_identifier'].blank? and not v['related_identifier'][0].blank?
        rel_identifier << "Related Identifier: #{v['related_identifier'][0]}"
      end
      if v.include?('related_identifier_type') and not v['related_identifier_type'].blank? and not v['related_identifier_type'][0].blank?
        rel_identifier << "Related Identifier Type: #{v['related_identifier_type'][0]}"
      end
      if v.include?('relation_type') and not v['relation_type'].blank? and not v['relation_type'][0].blank?
        rel_identifier << "Relation Type: #{v['relation_type'][0]}"
      end
      if v.include?('related_metadata_scheme') and not v['related_metadata_scheme'].blank? and not v['related_metadata_scheme'][0].blank?
        rel_identifier << "Related Metadata Scheme: #{v['related_metadata_scheme'][0]}"
      end
      if v.include?('scheme_uri') and not v['scheme_uri'].blank? and not v['scheme_uri'][0].blank?
        rel_identifier << "Scheme URI: #{v['scheme_uri'][0]}"
      end
      if v.include?('scheme_type') and not v['scheme_type'].blank? and not v['scheme_type'][0].blank?
        rel_identifier << "Scheme Type: #{v['scheme_type'][0]}"
      end      
      html << rel_identifier.join('<br>')
    end
    %(#{html + "<br><br>"})
  end
end
