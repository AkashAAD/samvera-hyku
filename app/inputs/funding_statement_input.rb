class FundingStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    funding_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    # if object.required?(:creator_nested) and index == 0
    #   required = true
    # end
    # --- funding_reference
    field = :funding_reference
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- funder_name
    field = :funder_name
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- funder_identifier
    field = :funder_identifier
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- funder_identifier_type
    field = :funder_identifier_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first
    role_options = FunderIdentifierTypesService.select_all_options
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << template.select_tag(field_name, template.options_for_select(role_options, field_value),
        prompt: 'Select fund identifier played', label: '', class: 'select form-control', id: field_id, required: false)
    out << '  </div>'
    out << '</div>' # row

    # --- award_number
    field = :award_number
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << '  </div>'
    out << '</div>' # row

    # --- award_uri
    field = :award_uri
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << "  </div>"

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << "  </div>"
    out << "</div>"

    # --- award_title
    field = :award_title
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = funding_statement.send(field).first
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << "  </div>"

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    out << "  </div>"
    out << "</div>"

    out << "<div class='row'>"
    # --- delete checkbox
    field_label = 'Creator'
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # last row
    out
  end
end
