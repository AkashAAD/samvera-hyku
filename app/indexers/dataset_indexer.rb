# Generated via
#  `rails generate hyrax:work Dataset`
class DatasetIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # Uncomment this block if you want to add custom indexing behavior:
  def generate_solr_document
    super.tap do |solr_doc|
      
      # other title
      solr_doc[Solrizer.solr_name('other_title', :stored_searchable)] = object.other_title.map { |r| r.title.first }
      solr_doc[Solrizer.solr_name('other_title', :displayable)] = object.other_title.to_json      

      # work review process
      # solr_doc[Solrizer.solr_name('work_review_process', :stored_searchable)] = object.work_review_process.map{ |r| r.status.first }
      # solr_doc[Solrizer.solr_name('work_review_process', :displayable)] = object.work_review_process.to_json

      # reviewers
      solr_doc[Solrizer.solr_name('reviewers', :stored_searchable)] = object.reviewers.map { |r| r.reviewer.first  }
      solr_doc[Solrizer.solr_name('reviewers', :displayable)] = object.reviewers.to_json

      # identifiers
      solr_doc[Solrizer.solr_name('identifier_nested', :symbol)] = object.identifier_nested.map { |i| i.obj_id.first }
      solr_doc[Solrizer.solr_name('identifier_nested', :displayable)] = object.identifier_nested.to_json
      object.identifier_nested.each do |i|
        unless (i.obj_id_scheme.first.blank? or i.obj_id.first.blank?)
          solr_doc[Solrizer.solr_name("identifier_#{i.obj_id_scheme.first.downcase}", :symbol)] = i.obj_id.reject(&:blank?)
        end
      end

      # creator
      creators = object.creator_nested.map { |cr| (cr.name + cr.orcid).reject(&:blank?).join(' ') }
      solr_doc[Solrizer.solr_name('creator_nested', :facetable)] = creators
      solr_doc[Solrizer.solr_name('creator_nested', :stored_searchable)] = creators
      solr_doc[Solrizer.solr_name('creator_nested', :displayable)] = object.creator_nested.to_json
      
      # contributor
      # contributors = object.contributor_nested.map { |cr| (cr.contributor_first_name + cr.contributor_last_name).reject(&:blank?).join(' ') }
      # solr_doc[Solrizer.solr_name('contributor_nested', :facetable)] = contributors
      # solr_doc[Solrizer.solr_name('contributor_nested', :stored_searchable)] = contributors
      # solr_doc[Solrizer.solr_name('contributor_nested', :displayable)] = object.contributor_nested.to_json

      # date
      # solr_doc[Solrizer.solr_name('date_nested', :stored_searchable)] = object.date_nested.map { |s| s.date.first }.reject(&:blank?)
      # solr_doc[Solrizer.solr_name('date_nested', :facetable)] = object.date_nested.map { |s| s.date.first }.reject(&:blank?)
      # solr_doc[Solrizer.solr_name('date_nested', :displayable)] = object.date_nested.to_json

      # subject
      solr_doc[Solrizer.solr_name('subject_nested', :stored_searchable)] = object.subject_nested.map { |s| s.subject.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('subject_nested', :facetable)] = object.subject_nested.map { |s| s.subject.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('subject_nested', :displayable)] = object.subject_nested.to_json
      
      # #alternate identifier
      # solr_doc[Solrizer.solr_name('alt_identifier_nested', :stored_searchable)] = object.alt_identifier_nested.map { |s| s.alt_identifier.first }.reject(&:blank?)
      # solr_doc[Solrizer.solr_name('alt_identifier_nested', :facetable)] = object.alt_identifier_nested.map { |s| s.alt_identifier.first }.reject(&:blank?)
      # solr_doc[Solrizer.solr_name('alt_identifier_nested', :displayable)] = object.alt_identifier_nested.to_json

      #alternate identifier
      solr_doc[Solrizer.solr_name('related_identifier_nested', :stored_searchable)] = object.related_identifier_nested.map { |s| s.related_identifier.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('related_identifier_nested', :facetable)] = object.related_identifier_nested.map { |s| s.related_identifier.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('related_identifier_nested', :displayable)] = object.related_identifier_nested.to_json

      # #rights
      # solr_doc[Solrizer.solr_name('rights_nested', :stored_searchable)] = object.rights_nested.map { |s| s.rights.first }.reject(&:blank?)
      # solr_doc[Solrizer.solr_name('rights_nested', :facetable)] = object.rights_nested.map { |s| s.rights.first }.reject(&:blank?)
      # solr_doc[Solrizer.solr_name('rights_nested', :displayable)] = object.rights_nested.to_json

      #description
      solr_doc[Solrizer.solr_name('description_nested', :stored_searchable)] = object.description_nested.map { |s| s.description.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('description_nested', :facetable)] = object.description_nested.map { |s| s.description.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('description_nested', :displayable)] = object.description_nested.to_json

      #funding
      solr_doc[Solrizer.solr_name('funding_nested', :stored_searchable)] = object.funding_nested.map { |s| s.funding_reference.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('funding_nested', :facetable)] = object.funding_nested.map { |s| s.funding_reference.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('funding_nested', :displayable)] = object.funding_nested.to_json    

      #geolocation
      solr_doc[Solrizer.solr_name('geolocation_nested', :stored_searchable)] = object.geolocation_nested.map { |s| s.geolocation.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('geolocation_nested', :facetable)] = object.geolocation_nested.map { |s| s.geolocation.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('geolocation_nested', :displayable)] = object.geolocation_nested.to_json

    end
  end
end
