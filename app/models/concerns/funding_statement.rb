class FundingStatement < ActiveTriples::Resource
  include CommonMethods

  property :funding_reference, predicate: ::RDF::Vocab::SIOC.reference
  property :funder_name, predicate: ::RDF::Vocab::MODS.name
  property :funder_identifier, predicate: ::RDF::Vocab::Identifiers.id
  property :funder_identifier_type, predicate: ::RDF::Vocab::MODS.IdentifierGroup
  property :award_number, predicate: ::RDF::Vocab::Bibframe.classificationNumber
  property :award_uri, predicate: ::RDF::Vocab::Identifiers.uri
  property :award_title, predicate: ::RDF::Vocab::Bibframe.Title

  # Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#funding#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end