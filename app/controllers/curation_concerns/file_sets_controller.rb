module CurationConcerns
  class FileSetsController < ApplicationController
    include CurationConcerns::FileSetsControllerBehavior

    self.show_presenter = ::FileSetPresenter
    self.form_class = CurationConcerns::Forms::FileSetEditForm

    # this is provided so that implementing application can override this
    # behavior and map params to different attributes
    def update_metadata
      file_attributes = ::FileSetEditForm.model_attributes(attributes)
      actor.update_metadata(file_attributes)
    end

    # inject conforms_to into permitted params
    def file_set_params
      super.tap do |permitted_params|
        permitted_params[:conforms_to] = params[:file_set][:conforms_to]
        permitted_params[:mime_type] = params[:file_set][:mime_type]
      end
    end

    def actor
      @actor ||= GeoConcerns::FileSetActor.new(@file_set, current_user)
    end
  end
end
