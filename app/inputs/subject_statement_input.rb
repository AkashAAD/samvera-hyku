class SubjectStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    subject_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    # if object.required?(:subject_nested) and index == 0
    #   required = true
    # end

    # single row
    # out << "<div class='row'>"
    # --- subject
    # field = :subject
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = subject_statement.send(field).first

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << '  </div>'
    # out << '</div>'

    # --- subject
    field = :subject
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = subject_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # # --- subject_scheme
    # field = :subject_scheme
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = subject_statement.send(field).first

    # out << "<br><div class='row'>"
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
    # field_value = subject_statement.send(field).first

    # out << "<br><div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"

    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row      
    
    # # --- value_uri
    # field = :value_uri
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = subject_statement.send(field).first

    # out << "<br><div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"

    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row            

    # --- delete checkbox
    out << "<div class='row'>"
    field_label = 'Subject'
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # row
    out
  end

end
