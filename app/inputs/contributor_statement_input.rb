class ContributorStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    contributor_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    if object.required?(:creator_nested) and index == 0
      required = true
    end
    # --- full_name
    field = :full_name
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- first_name
    field = :contributor_first_name
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- last_name
    field = :contributor_last_name
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- affiliation
    field = :contributor_affiliation
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << '  </div>'
    out << '</div>' # row

    # --- name_identifier
    field = :contributor_name_identifier
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << "  </div>"

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << "  </div>"
    out << "</div>"

    # --- name_identifier_scheme
    field = :name_identifier_scheme
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << "  </div>"

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << "  </div>"
    out << "</div>"    

    # --- scheme_uri
    field = :contributor_scheme_uri
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << "  </div>"

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << "  </div>"
    out << "</div>"

    # last row
    out << "<div class='row'>"


    # --- name_type
    name_types = NameTypesService.select_all_options
    field = :name_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first

    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-6'>"
    out << template.select_tag(field_name, template.options_for_select(name_types, field_value.nil? ? 'Personal'  : field_value),
        prompt: 'Select name type played', label: '', class: 'select form-control', id: field_id, required: required)
    out << '  </div>'
    out << '<br><br>'
    # --- contributor_type
    contributor_types = ContributorTypesService.select_all_options
    field = :contributor_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = contributor_statement.send(field).first

    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-6'>"
    out << template.select_tag(field_name, template.options_for_select(contributor_types, field_value),
        prompt: 'Select contributor type played', label: '', class: 'select form-control', id: field_id, required: required)
    out << '  </div>'
    # out << '</div>'

    # --- delete checkbox
    field_label = 'Creator'
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # last row
    out
  end
end
