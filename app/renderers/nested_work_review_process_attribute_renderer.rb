class NestedWorkReviewProcessAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      work_review_process = []
      if v.include?('status') and not v['status'].blank? and not v['status'][0].blank?
        work_review_process << "Work status: #{link_to(ERB::Util.h(v['status'][0]), search_path(v['status'][0]))}"
      end
      if v.include?('comment') and not v['comment'].blank? and not v['comment'][0].blank?
        work_review_process << "Comment: #{v['comment'][0]}"
      end
      if v.include?('outcome') and not v['outcome'].blank? and not v['outcome'][0].blank?
        work_review_process << "Outcome: #{v['outcome'][0]}"
      end
      if v.include?('reviewer_acceptance_due_date') and not v['reviewer_acceptance_due_date'].blank? and not v['reviewer_acceptance_due_date'][0].blank?
        work_review_process << "Reviewer acceptance Due Data: #{v['reviewer_acceptance_due_date'][0]}"
      end
      if v.include?('reviewer_completing_due_date') and not v['reviewer_completing_due_date'].blank? and not v['reviewer_completing_due_date'][0].blank?
        work_review_process << "Reviewer Completing Due Date: #{v['reviewer_completing_due_date'][0]}"
      end
      if v.include?('reviewers') and not v['reviewers'].blank? and not v['reviewers'][0].blank?
        work_review_process << "<b>Reviewers:</b>"
        v['reviewers'].each do |id|
          user = User.find_by_id(id)
          work_review_process << "Name: #{user.display_name} | Email: #{link_to(ERB::Util.h(user.email), search_path(user.email))}"
        end
      end
      html << work_review_process.join('<br>')
    end
    html = html.join('<br/>')
    %(#{html})
  end
end
