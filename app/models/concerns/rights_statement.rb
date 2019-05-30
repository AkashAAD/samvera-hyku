class RightsStatement < ActiveTriples::Resource
  include CommonMethods

  property :rights, predicate: ::RDF::Vocab::DC11.rights
  property :rights_uri, predicate: ::RDF::Vocab::Identifiers.uri

  ##Necessary to get AT to create hash URIs
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#rights#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end