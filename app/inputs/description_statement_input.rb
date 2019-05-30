class DescriptionStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    description_statement = value

    # --- description type and description - single row
    out << "<br><div class='row'>"

    # --- description type
    field = :description_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = description_statement.send(field).first
    title_options = DescriptionTypesService.select_all_options

    out << "  <div class='col-md-12'>"
    out << template.select_tag(field_name, template.options_for_select(title_options, field_value),
        label: '', class: 'select form-control', prompt: 'choose type', id: field_id)
    out << '  </div>'
    out << '</div>'
    out << '<br>'
    # --- description
    field = :description
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = description_statement.send(field).first
    out << "<div class='row'>"
    out << "  <div class='col-md-12'>"
    out << @builder.text_area(field_name,
        options.merge(value: field_value, name: field_name, id: field_id))
    out << '  </div>'
    out << '</div>'

    # --- delete checkbox
    # field_label = 'Alternative titles'
    # out << "  <div class='col-md-3'>"
    # out << destroy_widget(attribute_name, index, field_label)
    # out << '  </div>'

    # out << '</div>' # last row
    out
  end
end
