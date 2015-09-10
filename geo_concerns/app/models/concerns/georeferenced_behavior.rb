module GeoreferencedBehavior
  extend ActiveSupport::Concern

  included do
    
    # Example values
    #   urn:ogc:def:crs:EPSG::3163
    #   urn:ogc:def:crs,crs:EPSG::4269,crs:EPSG::5713
    #   http://www.opengis.net/def/crs/epsg/0/3163 (maybe? referred to in WFS query document)
    # See http://portal.opengeospatial.org/files/?artifact_id=30575
    property :crs, predicate: ::RDF::URI.new(PREFIXES[:ogc] + 'crsURI'), multiple: false do |index|
      index.as :stored_searchable
    end
    
    validates_presence_of :crs,  message: 'Your work must have a CRS.'
    
  end
end
