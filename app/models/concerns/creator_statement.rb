class CreatorStatement < ActiveTriples::Resource
	include CommonMethods

  configure type: ::RDF::Vocab::FOAF.Person
  # property :creator_first_name, predicate: ::RDF::Vocab::FOAF.givenName
  # property :creator_last_name, predicate: ::RDF::Vocab::FOAF.familyName
  property :name, predicate: ::RDF::Vocab::VCARD.hasName
  property :orcid, predicate: ::RDF::Vocab::DataCite.orcid
  property :role, predicate: ::RDF::Vocab::MODS.roleRelationship
  property :creator_affiliation, predicate: ::RDF::Vocab::VMD.affiliation
  # property :creator_scheme_uri, predicate: ::RDF::Vocab::Identifiers.uri
  # property :creator_name_identifier, predicate: ::RDF::Vocab::Identifiers.local

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