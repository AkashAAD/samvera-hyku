# Generated via
#  `rails generate hyrax:work WorkReview`
class WorkReview < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  belongs_to :dataset, predicate: ::RDF::Vocab::PROV.entity
  self.indexer = WorkReviewIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }
  
  property :admin_comment, predicate: ::RDF::Vocab::VS.moreinfo, multiple: false do |index|
    index.as :stored_searchable
  end

  property :user_comment, predicate: ::RDF::Vocab::DataCite.hasDescription, multiple: false do |index|
    index.as :stored_searchable
  end

  property :outcome, predicate: ::RDF::Vocab::BIBO.describe, multiple: false do |index|
    index.as :stored_searchable
  end

  property :review_status, predicate: ::RDF::Vocab::Bibframe.circulationStatus, multiple: false do |index|
    index.as :stored_searchable
  end

  property :review_dataset_id, predicate: ::RDF::Vocab::Bibframe.itemId, multiple: false do |index|
    index.as :stored_searchable
  end

  property :reviewer_email, predicate: ::RDF::Vocab::OG.email, multiple: false do |index|
    index.as :stored_searchable
  end
  
  # belongs_to :dataset, predicate: ::RDF::Vocab::Ebsco.has_reviews
  include ::Hyrax::BasicMetadata
end
