# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  class DatasetPresenter < Hyrax::WorkShowPresenter
    # delegate :publication_year, :other_title, :creator_nested, :identifier_nested, :subject_nested, :contributor_nested, :date_nested, to: :solr_document
    delegate :reviewers, :work_review_process, :geolocation_nested, :work_status, :funding_nested, :description_nested, :dataset_size, :dataset_format, :dataset_version, :publication_year, :other_title, :creator_nested, :identifier_nested, :subject_nested, :related_identifier_nested, to: :solr_document
  end
end
