module BasicGeoMetadata
  extend ActiveSupport::Concern

  included do

    # Example value: ENVELOPE(-179.14734, 179.778465, 71.390482, 17.881242)
    # See http://portal.opengeospatial.org/files/?artifact_id=20555
    property :solr_geom, predicate: ::RDF::URI.new("http://www.opengis.net/def/serviceType/ogc/csw/2.0.2#envelope"), multiple: false do |index|
      
      # Solrizer needs to be configured to use location_rpt; not working here.
      index.as Solrizer::Descriptor.new(:location_rpt, :stored, :indexed)
    end

    # Alternate or additional bbox
    property :georss_box, predicate: ::RDF::URI.new("http://www.georss.org/georss/box"), multiple: false do |index|
      index.as :stored_searchable
    end
    
    validates_presence_of :title,  message: 'Your work must have a title.'
    validates_presence_of :georss_box,  message: 'Your work must have a bbox.'
  end
end
