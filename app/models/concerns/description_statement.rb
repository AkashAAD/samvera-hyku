class DescriptionStatement < ActiveTriples::Resource
  include CommonMethods

  property :description, predicate: ::RDF::Vocab::RSS.description
  property :description_type, predicate: ::RDF::Vocab::DataCite.hasDescriptionType

  # Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#description#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end