class GeolocationStatement < ActiveTriples::Resource
  include CommonMethods

  property :geolocation, predicate: ::RDF::Vocab::DOAP.location
  # property :geolocation_point, predicate: ::RDF::Vocab::DCAT.contactPoint
  # property :point_longitude, predicate: ::RDF::Vocab::VCARD.longitude
  # property :point_latitude, predicate: ::RDF::Vocab::VCARD.latitude
  # property :geo_location_box, predicate: ::RDF::Vocab::GEOJSON.bbox
  # property :west_bound_longitude, predicate: ::RDF::Vocab::OG.longitude
  # property :east_bound_longitude, predicate: ::RDF::Vocab::MA.locationLongitude
  # property :south_bound_latitude, predicate: ::RDF::Vocab::OG.latitude
  # property :north_bound_latitude, predicate: ::RDF::Vocab::MA.locationLatitude
  # property :geolocation_place, predicate: ::RDF::Vocab::MODS.placeOfOrigin
  # property :geolocation_polygon, predicate: ::RDF::Vocab::GEOJSON.Polygon
  # property :polygon_point, predicate: ::RDF::Vocab::GEOJSON.Point
  # property :pointLongitude
  # property :pointLatitude
  # property :in_polygon_point, predicate: ::RDF::Vocab::GEOJSON.MultiPoint
  # property :pointLongitude
  # property :pointLatitude
    

  # property :full_name, predicate: ::RDF::Vocab::MADS.FullNameElement
  # property :name_type, predicate: ::RDF::Vocab::HT.HeaderName
  # property :first_name, predicate: ::RDF::Vocab::FOAF.givenName
  # property :last_name, predicate: ::RDF::Vocab::FOAF.familyName
  # property :affiliation, predicate: ::RDF::Vocab::VMD.affiliation
  # property :scheme_uri, predicate: ::RDF::Vocab::Identifiers.uri
  # property :name_identifier_scheme, predicate: ::RDF::Vocab::SKOS.ConceptScheme
  # property :name_identifier, predicate: ::RDF::Vocab::Identifiers.local

  # Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#geolocation#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end