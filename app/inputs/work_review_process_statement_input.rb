class WorkReviewProcessStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    person_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    reviewers = Role.find_by_name('reviewer').try(:users)

    # --- name
    field = :reviewers
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'
    out << "  <div class='col-md-7'>"
    out << template.select_tag(field_name, template.options_for_select(reviewers.pluck(:display_name, :id), field_value),
        prompt: '-Select Reviewer-', label: '', class: 'select form-control', id: field_id, required: required, multiple: true)
    out << '  </div>'
    out << '</div>' # row

    # --- status
    field = :status
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<br><div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'
    out << "  <div class='col-md-7'>"
    out << template.select_tag(field_name, template.options_for_select(WorkReviewStatusesService.select_all_options, field_value),
        prompt: '-Select Work Status-', label: '', class: 'select form-control', id: field_id, required: required)
    out << '  </div>'
    out << '</div>' # row

    # --- upload_user_report
    field = :upload_user_report
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'
    out << "  <div class='col-md-7'>"
    out << @builder.file_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- upload_admin_report
    field = :upload_admin_report
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'
    out << "  <div class='col-md-7'>"
    out << @builder.file_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- outcome
    field = :outcome
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-7'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- reviewer_acceptance_due_date
    field = :reviewer_acceptance_due_date
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-7'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required, class: 'form-control dataset_reviewer_acceptance_due_date'))
    out << '  </div>'
    out << '</div>' # row   
    
    # --- reviewer_completing_due_date
    field = :reviewer_completing_due_date
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-7'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required, class: 'form-control dataset_reviewer_completing_due_date'))
    out << '  </div>'
    out << '</div>' # row

    # --- comment
    field = :comment
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-5'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-7'>"
    out << @builder.text_area(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- delete checkbox
    field_label = 'Creator'
    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # last row
    out  
  end
end
