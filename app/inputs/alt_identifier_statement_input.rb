# class AltIdentifierStatementInput < NestedAttributesInput

# protected

#   def build_components(attribute_name, value, index, options)
#     out = ''

#     alt_identifier_statement = value

#     # --- alt_identifier and alternate_identifier_type - single row
#     out << "<div class='row'>"

#     # --- alt_identifier
#     field = :alt_identifier
#     field_name = name_for(attribute_name, index, field)
#     field_id = id_for(attribute_name, index, field)
#     field_value = alt_identifier_statement.send(field).first

#     out << "  <div class='col-md-2'>"
#     out << template.label_tag(field_name, field.to_s.humanize, required: false)
#     out << '  </div>'

#     out << "  <div class='col-md-3'>"
#     out << @builder.text_field(field_name,
#         options.merge(value: field_value, name: field_name, id: field_id))
#     out << '  </div>'

#     # --- alternate_identifier_type
#     field = :alternate_identifier_type
#     field_name = name_for(attribute_name, index, field)
#     field_id = id_for(attribute_name, index, field)
#     field_value = alt_identifier_statement.send(field).first
    
#     out << "  <div class='col-md-2'>"
#     out << template.label_tag(field_name, field.to_s.humanize, required: false)
#     out << '  </div>'

#     out << "  <div class='col-md-3'>"
#     out << @builder.text_field(field_name,
#         options.merge(value: field_value, name: field_name, id: field_id))
#     out << '  </div>'

#     # --- delete checkbox
#     field_label = 'Alternative titles'
#     out << "  <div class='col-md-2'>"
#     out << destroy_widget(attribute_name, index, field_label)
#     out << '  </div>'

#     out << '</div>' # last row
#     out
#   end
# end
