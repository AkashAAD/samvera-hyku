class NestedGeolocationAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      geolocation = []
      if v.include?('geolocation') and not v['geolocation'].blank? and not v['geolocation'][0].blank?
        geolocation << "Geolocation: #{v['geolocation'][0]}"
      end
      # if v.include?('geolocation_point') and not v['geolocation_point'].blank? and not v['geolocation_point'][0].blank?
      #   geolocation << "Geolocation Point: #{v['geolocation_point'][0]}"
      # end
      # if v.include?('geolocation_identifier') and not v['geolocation_identifier'].blank? and not v['geolocation_identifier'][0].blank?
      #   geolocation << "Geolocation Identifier: #{v['geolocation_identifier'][0]}"
      # end
      # if v.include?('point_longitude') and not v['point_longitude'].blank? and not v['point_longitude'][0].blank?
      #   geolocation << "Point Longitude: #{v['point_longitude'][0]}"
      # end
      # if v.include?('point_latitude') and not v['point_latitude'].blank? and not v['point_latitude'][0].blank?
      #   geolocation << "Point Latitude: #{v['point_latitude'][0]}"
      # end
      # if v.include?('geo_location_box') and not v['geo_location_box'].blank? and not v['geo_location_box'][0].blank?
      #   geolocation << "Geolocation Box: #{v['geo_location_box'][0]}"
      # end
      # if v.include?('west_bound_longitude') and not v['west_bound_longitude'].blank? and not v['west_bound_longitude'][0].blank?
      #   geolocation << "West Bound Longitude: #{v['west_bound_longitude'][0]}"
      # end
      # if v.include?('east_bound_longitude') and not v['east_bound_longitude'].blank? and not v['east_bound_longitude'][0].blank?
      #   geolocation << "East Bound Longitude: #{v['east_bound_longitude'][0]}"
      # end
      # if v.include?('south_bound_latitude') and not v['south_bound_latitude'].blank? and not v['south_bound_latitude'][0].blank?
      #   geolocation << "South Bound Longitude: #{v['south_bound_latitude'][0]}"
      # end
      # if v.include?('north_bound_latitude') and not v['north_bound_latitude'].blank? and not v['north_bound_latitude'][0].blank?
      #   geolocation << "North Bound Longitude: #{v['north_bound_latitude'][0]}"
      # end
      # if v.include?('geolocation_place') and not v['geolocation_place'].blank? and not v['geolocation_place'][0].blank?
      #   geolocation << "Geolocation Place: #{v['geolocation_place'][0]}"
      # end
      # if v.include?('geolocation_polygon') and not v['geolocation_polygon'].blank? and not v['geolocation_polygon'][0].blank?
      #   geolocation << "Geolocation Polygon: #{v['geolocation_polygon'][0]}"
      # end
      # if v.include?('polygon_point') and not v['polygon_point'].blank? and not v['polygon_point'][0].blank?
      #   geolocation << "Polygon Point: #{v['polygon_point'][0]}"
      # end
      # if v.include?('in_polygon_point') and not v['in_polygon_point'].blank? and not v['in_polygon_point'][0].blank?
      #   geolocation << "In Polygon Point: #{v['in_polygon_point'][0]}"
      # end
      html << geolocation.join('<br>')
    end
    html = html.join('<br>')
    %(#{html})
  end
end
