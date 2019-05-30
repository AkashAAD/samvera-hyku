# class AltIndentifierStatement < ActiveTriples::Resource
#   include CommonMethods

#   property :alt_identifier, predicate: ::RDF::Vocab::Identifiers.id
#   # property :alternate_identifier_type, predicate: ::RDF::Vocab::MODS.IdentifierGroup

#   # Necessary to get AT to create hash URIs.
#   def initialize(uri, parent)
#     if uri.try(:node?)
#       uri = RDF::URI("#alt_identifier#{uri.to_s.gsub('_:', '')}")
#     elsif uri.start_with?("#")
#       uri = RDF::URI(uri)
#     end
#     super
#   end  
# end