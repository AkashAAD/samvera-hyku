# Generated via
#  `rails generate hyrax:work Dataset`
class Dataset < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = DatasetIndexer
  has_many :work_reviews
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your dataset work must have a title.' }
  self.human_readable_type = 'Dataset'
  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  property :publication_year, predicate: ::RDF::Vocab::DWC.year, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end  
  property :dataset_size, predicate: ::RDF::Vocab::NFO.fileSize, multiple: false do |index|
    index.as :stored_searchable
  end
  # property :work_status, predicate: ::RDF::Vocab::Bibframe.circulationStatus, multiple: false do |index|
  #   index.as :stored_searchable
  # end
  property :dataset_format, predicate: ::RDF::Vocab::DC11.format, multiple: false do |index|
    index.as :stored_searchable
  end
  property :dataset_version, predicate: ::RDF::Vocab::CNT.version, multiple: false do |index|
    index.as :stored_searchable
  end
  property :reviewers, predicate: ::RDF::Vocab::V.reviewer, class_name: "ReviewersStatement"
  # property :work_review_process, predicate: ::RDF::Vocab::FOAF.workInfoHomepage, class_name: "WorkReviewProcessStatement"
  property :other_title, predicate: ::RDF::Vocab::Bibframe.titleVariation, class_name: "OtherTitleStatement"
  property :subject_nested, predicate: ::RDF::Vocab::DC.subject, class_name: "SubjectStatement"
  property :identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "ObjectIdentifier"
  property :creator_nested, predicate: ::RDF::Vocab::SIOC.has_creator, class_name: "CreatorStatement"
  # property :contributor_nested, predicate: ::RDF::Vocab::SIOC.has_creator, class_name: "ContributorStatement"
  # property :date_nested, predicate: ::RDF::Vocab::DC.date, class_name: "DateStatement"
  # property :alt_identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "AltIndentifierStatement"
  property :related_identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "RelatedIdentifierStatement"
  # property :rights_nested, predicate: ::RDF::Vocab::DC11.rights, class_name: "RightsStatement"
  property :description_nested, predicate: ::RDF::Vocab::RSS.description, class_name: "DescriptionStatement"
  property :funding_nested, predicate: ::RDF::Vocab::FOAF.fundedBy, class_name: "FundingStatement"
  property :geolocation_nested, predicate: ::RDF::Vocab::DOAP.location, class_name: "GeolocationStatement"

  include ::Hyrax::BasicMetadata
  include DatasetNestedAttributes
end
