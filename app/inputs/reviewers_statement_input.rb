class ReviewersStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    person_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    reviewers = Role.find_by_name('reviewer').try(:users)

    # --- name
    field = :reviewer
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'
    out << "  <div class='col-md-5'>"
    out << template.select_tag(field_name, template.options_for_select(reviewers.pluck(:display_name, :id), field_value),
        prompt: '-Select Reviewer-', label: '', class: 'select form-control', id: field_id, required: required)
    out << '  </div>'
    field_label = 'Creator'
    out << "  <div class='col-md-2'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'    
    out << '</div>' # row

    # --- delete checkbox
    # field_label = 'Creator'
    # out << "<div class='row'>"


    # out << '</div>' # last row
    out  
  end
end
