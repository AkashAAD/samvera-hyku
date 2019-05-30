class RelatedIdentifierStatement < ActiveTriples::Resource
  include CommonMethods

  property :related_identifier, predicate: ::RDF::Vocab::Identifiers.id
  property :related_identifier_type, predicate: ::RDF::Vocab::MODS.IdentifierGroup
  property :relation_type, predicate: ::RDF::Vocab::MODS.roleRelationship
  # property :related_metadata_scheme, predicate: ::RDF::Vocab::MODS.adminMetadata
  # property :scheme_uri, predicate: ::RDF::Vocab::Identifiers.uri
  # property :scheme_type, predicate: ::RDF::Vocab::MODS.classificationGroupScheme

  ##Necessary to get AT to create hash URIs
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#rel_identifier#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end