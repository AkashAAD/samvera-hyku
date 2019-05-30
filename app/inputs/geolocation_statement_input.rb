class GeolocationStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    geolocation_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    # if object.required?(:creator_nested) and index == 0
    #   required = true
    # end

    # --- geolocation
    field = :geolocation
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = geolocation_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"

    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # # --- geolocation_point
    # field = :geolocation_point
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row

    # # --- point_longitude
    # field = :point_longitude
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"

    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row

    # # --- point_latitude
    # field = :point_latitude
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: required)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"

    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: required))
    # out << '  </div>'
    # out << '</div>' # row


    # # --- geo_location_box
    # field = :geo_location_box
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first

    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << '  </div>'

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name,
    #     options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << '  </div>'
    # out << '</div>' # row

    # # --- west_bound_longitude
    # field = :west_bound_longitude
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"

    # # --- east_bound_longitude
    # field = :east_bound_longitude
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"

    # # --- south_bound_latitude
    # field = :south_bound_latitude
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"

    # # --- north_bound_latitude
    # field = :north_bound_latitude
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"    

    # # --- geolocation_place
    # field = :geolocation_place
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"

    # # --- geolocation_polygon
    # field = :geolocation_polygon
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>" 
    
    # # --- polygon_point
    # field = :polygon_point
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"

    # # --- in_polygon_point
    # field = :in_polygon_point
    # field_name = name_for(attribute_name, index, field)
    # field_id = id_for(attribute_name, index, field)
    # field_value = geolocation_statement.send(field).first
    # out << "<div class='row'>"
    # out << "  <div class='col-md-3'>"
    # out << template.label_tag(field_name, field.to_s.humanize, required: false)
    # out << "  </div>"

    # out << "  <div class='col-md-9'>"
    # out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: false))
    # out << "  </div>"
    # out << "</div>"       

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
