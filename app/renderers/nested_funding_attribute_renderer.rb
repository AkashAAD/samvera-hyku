class NestedFundingAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      funder = []
      if v.include?('funding_reference') and not v['funding_reference'].blank? and not v['funding_reference'][0].blank?
        funder << "Funding Reference: #{v['funding_reference'][0]}"
      end
      if v.include?('funder_name') and not v['funder_name'].blank? and not v['funder_name'][0].blank?
        funder << "Funder Name: #{v['funder_name'][0]}"
      end
      if v.include?('funder_identifier') and not v['funder_identifier'].blank? and not v['funder_identifier'][0].blank?
        funder << "Funder Identifier: #{v['funder_identifier'][0]}"
      end
      if v.include?('funder_identifier_type') and not v['funder_identifier_type'].blank? and not v['funder_identifier_type'][0].blank?
        funder << "Funder Identifier Type: #{v['funder_identifier_type'][0]}"
      end
      if v.include?('award_number') and not v['award_number'].blank? and not v['award_number'][0].blank?
        funder << "Award Number: #{v['award_number'][0]}"
      end
      if v.include?('award_uri') and not v['award_uri'].blank? and not v['award_uri'][0].blank?
        funder << "Award URI: #{v['award_uri'][0]}"
      end
      if v.include?('award_title') and not v['award_title'].blank? and not v['award_title'][0].blank?
        funder << "Award Title: #{v['award_title'][0]}"
      end            
      html << funder.join('<br>')
    end
    html = html.join('<br>')
    %(#{html})
  end
end
