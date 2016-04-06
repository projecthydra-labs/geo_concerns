FactoryGirl.define do
  factory :image_file, class: FileSet do
    initialize_with { new(mime_type: 'image/tiff') }
    transient do
      user { FactoryGirl.create(:user) }
      content nil
    end

    after(:build) do |file, evaluator|
      file.title = ['An image file']
      file.apply_depositor_metadata(evaluator.user.user_key)
    end

    after(:create) do |file, evaluator|
      if evaluator.content
        Hydra::Works::UploadFileToGenericFile.call(file, evaluator.content)
      end
    end

    factory :image_file_with_image do
      after(:build) do |file, evaluator|
        FactoryGirl.create(:image, user: evaluator.user).image_files << file
      end
      after(:create) do |file, evaluator|
        if evaluator.content
          Hydra::Works::UploadFileToGenericFile.call(file, evaluator.content)
        end
        FactoryGirl.create(:image, user: evaluator.user).image_files << file
      end
    end
  end
end
