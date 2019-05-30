class NestedContributorAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      contributor = []
      creator_name = []
      if v.include?('full_name') and not v['full_name'].blank? and not v['full_name'][0].blank?
        contributor << "Full Name: #{link_to(ERB::Util.h(v['full_name'][0]), search_path(v['full_name'][0]))}"
      end
      if v.include?('contributor_first_name') and not v['contributor_first_name'].blank? and not v['contributor_first_name'][0].blank?
        contributor << "First Name: #{v['contributor_first_name'][0]}"
      end
      if v.include?('contributor_last_name') and not v['contributor_last_name'].blank? and not v['contributor_last_name'][0].blank?
        contributor << "Last Name: #{v['contributor_last_name'][0]}"
      end
      if v.include?('name_type') and not v['name_type'].blank? and not v['name_type'][0].blank?
        contributor << "Name Type: #{v['name_type'][0]}"
      end
      if v.include?('contributor_type') and not v['contributor_type'].blank? and not v['contributor_type'][0].blank?
        contributor << "Contributor Type: #{v['contributor_type'][0]}"
      end      
      if v.include?('contributor_affiliation') and not v['contributor_affiliation'].blank? and not v['contributor_affiliation'][0].blank?
        contributor << "Affiliation: #{v['contributor_affiliation'][0]}"
      end
      if v.include?('contributor_scheme_uri') and not v['contributor_scheme_uri'].blank? and not v['contributor_scheme_uri'][0].blank?
        contributor << "Scheme uri: #{v['contributor_scheme_uri'][0]}"
      end
      if v.include?('contributor_name_identifier') and not v['contributor_name_identifier'].blank? and not v['contributor_name_identifier'][0].blank?
        contributor << "Name identifier: #{v['contributor_name_identifier'][0]}"
      end
      if v.include?('name_identifier_scheme') and not v['name_identifier_scheme'].blank? and not v['name_identifier_scheme'][0].blank?
        contributor << "Name Identifier Scheme: #{v['name_identifier_scheme'][0]}"
      end
      html << contributor.join('<br>')
    end
    html = html.join('<br/><br/>')
    %(#{html})
  end
end
