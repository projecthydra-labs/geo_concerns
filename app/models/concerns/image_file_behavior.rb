# Attributes and methods for image files
module ImageFileBehavior
  extend ActiveSupport::Concern
  include Hydra::Works::GenericFileBehavior
  include ::CurationConcerns::GenericFileBehavior

  included do
    type [Hydra::PCDM::Vocab::PCDMTerms.Object,
      Hydra::Works::Vocab::WorksTerms.GenericFile,
      "http://projecthydra.org/geoconcerns/models#ImageFile"]
  end

 # Defines type by what it is and isn't
  # @return [Boolean]
  def concerns_geospatial?
    false
  end
  def concerns_image?
    false
  end
  def concerns_image_file?
    true
  end
  def concerns_raster?
    false
  end
  def concerns_raster_file?
    false
  end
  def concerns_vector?
    false
  end
  def concerns_vector_file?
    false
  end
  def concerns_external_metadata_file?
    false
  end

  # Retrieve the Image Work of which this Object is a member
  # @return [GeoConcerns::Image]
  def image
    parents.find { |parent| parent.class.included_modules.include?(GeoConcerns::ImageBehavior) }
  end
end
