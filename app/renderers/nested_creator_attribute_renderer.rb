class NestedCreatorAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      creator = []
      creator_name = []
      # if v.include?('creator_first_name') and not v['creator_first_name'].blank?
      #   creator_name = ['Full Name: '] + v['creator_first_name']
      # end
      # if v.include?('creator_last_name') and not v['creator_last_name'].blank?
      #   creator_name += v['creator_last_name']
      # end
      creator_name = creator_name.join(' ').strip
      if v.include?('name') and not v['name'][0].blank?
        creator << link_to(ERB::Util.h(v['name'][0]), search_path(v['name'][0]))
      elsif creator_name
        creator << link_to(ERB::Util.h(creator_name), search_path(creator_name))
      end
      if v.include?('creator_affiliation') and not v['creator_affiliation'].blank? and not v['creator_affiliation'][0].blank?
        creator << "Affiliation: #{v['creator_affiliation'][0]}"
      end
      if v.include?('orcid') and not v['orcid'].blank? and not v['orcid'][0].blank?
        creator << "Orcid: #{v['orcid'][0]}"
      end
      if v.include?('role') and not v['role'].blank? and not v['role'][0].blank?
        creator << "Role: #{v['role'][0]}"
      end
      # if v.include?('creator_scheme_uri') and not v['creator_scheme_uri'].blank? and not v['creator_scheme_uri'][0].blank?
      #   creator << "Scheme uri: #{v['creator_scheme_uri'][0]}"
      # end
      # if v.include?('creator_name_identifier') and not v['creator_name_identifier'].blank? and not v['creator_name_identifier'][0].blank?
      #   creator << "Name identifier: #{v['creator_name_identifier'][0]}"
      # end
      html << creator.join('<br>')
    end
    html = html.join('<br/><br/>')
    %(#{html})
  end
end
