class ContributorStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: ::RDF::Vocab::FOAF.Person
  property :contributor_type, predicate: ::RDF::Vocab::Bibframe.contributor
  property :full_name, predicate: ::RDF::Vocab::MADS.FullNameElement
  property :name_type, predicate: ::RDF::Vocab::HT.HeaderName
  property :contributor_first_name, predicate: ::RDF::Vocab::FOAF.givenName
  property :contributor_last_name, predicate: ::RDF::Vocab::FOAF.familyName
  property :contributor_affiliation, predicate: ::RDF::Vocab::VMD.affiliation
  property :contributor_scheme_uri, predicate: ::RDF::Vocab::Identifiers.uri
  property :name_identifier_scheme, predicate: ::RDF::Vocab::SKOS.ConceptScheme
  property :contributor_name_identifier, predicate: ::RDF::Vocab::Identifiers.local

  # Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#person#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end