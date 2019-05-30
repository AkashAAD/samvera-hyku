# frozen_string_literal: true

class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior

  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.
  use_extension(Hydra::ContentNegotiation)

  attribute :extent, Solr::Array, solr_name('extent')
  attribute :rendering_ids, Solr::Array, solr_name('hasFormat', :symbol)
 
  def publication_year
    self[Solrizer.solr_name('publication_year', :stored_searchable)]
  end

  def dataset_size
    self[Solrizer.solr_name('dataset_size', :stored_searchable)]
  end

  def work_status
    self[Solrizer.solr_name('work_status', :stored_searchable)]
  end

  def work_review_process
    self[Solrizer.solr_name('work_review_process', :displayable)]
  end

  def dataset_format
    self[Solrizer.solr_name('dataset_format', :stored_searchable)]
  end    

  def reviewers
    self[Solrizer.solr_name('reviewers', :displayable)]
  end

  def dataset_version
    self[Solrizer.solr_name('dataset_version', :stored_searchable)]
  end

  def identifier_nested
    self[Solrizer.solr_name('identifier_nested', :displayable)]
  end

  def creator_nested
    self[Solrizer.solr_name('creator_nested', :displayable)]
  end

  def other_title
    self[Solrizer.solr_name('other_title', :displayable)]
  end

  def subject_nested
    self[Solrizer.solr_name('subject_nested', :displayable)]
  end

  # def contributor_nested
  #   self[Solrizer.solr_name('contributor_nested', :displayable)]
  # end

  def date_nested
    self[Solrizer.solr_name('date_nested', :displayable)]
  end

  # def alt_identifier_nested
  #   self[Solrizer.solr_name('alt_identifier_nested', :displayable)]
  # end

  def related_identifier_nested
    self[Solrizer.solr_name('related_identifier_nested', :displayable)]
  end

  # def rights_nested
  #   self[Solrizer.solr_name('rights_nested', :displayable)]
  # end

  def description_nested
    self[Solrizer.solr_name('description_nested', :displayable)]
  end

  def funding_nested
    self[Solrizer.solr_name('funding_nested', :displayable)]
  end

  def geolocation_nested
    self[Solrizer.solr_name('geolocation_nested', :displayable)]
  end

end
