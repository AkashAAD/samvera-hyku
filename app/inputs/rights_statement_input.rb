class RightsStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    rights_statement = value

    # --- rights and rights_uri - single row
    out << "<div class='row'>"

    # --- rights
    field = :rights
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = rights_statement.send(field).first

    out << "  <div class='col-md-2'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << '  </div>'

    out << "  <div class='col-md-3'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id))
    out << '  </div>'

    # --- rights_uri
    field = :rights_uri
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = rights_statement.send(field).first
    
    out << "  <div class='col-md-2'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << '  </div>'

    out << "  <div class='col-md-3'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id))
    out << '  </div>'

    # --- delete checkbox
    field_label = 'Alternative titles'
    out << "  <div class='col-md-2'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # last row
    out
  end
end
