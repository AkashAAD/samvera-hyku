class ReviewersStatement < ActiveTriples::Resource
  include CommonMethods

  property :reviewer, predicate: ::RDF::Vocab::V.reviewer

  ##Necessary to get AT to create hash URIs
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#review#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end