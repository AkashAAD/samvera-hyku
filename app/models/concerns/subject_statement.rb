class SubjectStatement < ActiveTriples::Resource
  include CommonMethods

  property :subject, predicate: ::RDF::Vocab::MODS.subject
  # property :subject_scheme, predicate: ::RDF::Vocab::MODS.classificationGroupScheme
  # property :scheme_uri, predicate: ::RDF::Vocab::Identifiers.uri
  # property :value_uri, predicate: ::RDF::Vocab::BIBO.uri

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#subject#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end