class WorkReviewProcessStatement < ActiveTriples::Resource
  include CommonMethods

  property :reviewers, predicate: ::RDF::Vocab::MODS.relatedReview
  property :status, predicate: ::RDF::Vocab::Bibframe.circulationStatus
  property :comment, predicate: ::RDF::Vocab::DataCite.hasDescription
  property :upload_user_report, predicate: ::RDF::Vocab::EBUCore.folksonomy
  property :upload_admin_report, predicate: ::RDF::Vocab::MODS.adminMetadata
  property :outcome, predicate: ::RDF::Vocab::BIBO.describe
  property :reviewer_acceptance_due_date, predicate: ::RDF::Vocab::MADS.activityStartDate
  property :reviewer_completing_due_date, predicate: ::RDF::Vocab::MADS.activityEndDate

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#work_review_process#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end