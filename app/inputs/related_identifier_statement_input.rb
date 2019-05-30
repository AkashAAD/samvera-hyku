class RelatedIdentifierStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''
    rel_identifier_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    # if object.required?(:identifier_nested) and index == 0
    #   required = true
    # end

    # --- related_identifier
    field = :related_identifier
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = rel_identifier_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # # --- related_metadata_scheme
    # field = :related_metadata_scheme
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = rel_identifier_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row

    # # --- scheme_uri
    # field = :scheme_uri
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = rel_identifier_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row   
    
    # # --- scheme_type
    # field = :scheme_type
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = rel_identifier_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row        

    # --- related_identifier_type
    role_options = RdssIdentifierTypesService.select_all_options
    field = :related_identifier_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = rel_identifier_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-6'>"
    out << template.select_tag(field_name, template.options_for_select(role_options, field_value),
        prompt: 'Select related identifier type played', label: '', class: 'select form-control', id: field_id, required: required)
    out << '  </div>'
    out << '</div>'



    # --- relation_type
    role_options = RelationTypesService.select_all_options
    field = :relation_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = rel_identifier_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-6'>"
    out << template.select_tag(field_name, template.options_for_select(role_options, field_value),
        prompt: 'Select relation type played', label: '', class: 'select form-control', id: field_id, required: required)
    out << '  </div>'    
    out << '</div>'

    # --- delete checkbox
    field_label = 'Identifiers'
    out << "<div class='row'>"    
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'
    out << '</div>' # last row
    out
  end
end
