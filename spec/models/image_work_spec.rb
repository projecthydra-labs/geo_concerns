require 'spec_helper'

describe ImageWork do
  let(:user) { FactoryGirl.find_or_create(:jill) }
  let(:image_file1) { FileSet.new(geo_mime_type: 'image/jpeg') }
  let(:ext_metadata_file1) { FileSet.new(geo_mime_type: 'application/xml; schema=iso19139') }
  let(:ext_metadata_file2) { FileSet.new(geo_mime_type: 'application/xml; schema=iso19139') }
  let(:raster1) { RasterWork.new }
  let(:raster2) { RasterWork.new }
  let(:coverage) { GeoConcerns::Coverage.new(43.039, -69.856, 42.943, -71.032) }

  it 'updates the title' do
    subject.attributes = { title: ['An image work'] }
    expect(subject.title).to eq(['An image work'])
  end

  describe 'metadata' do
    it 'has descriptive metadata' do
      expect(subject).to respond_to(:title)
    end
  end

  describe 'with acceptable inputs' do
    subject { described_class.new }
    it 'adds image file set, metadata file set, and raster work' do
      subject.members << image_file1
      subject.members << ext_metadata_file1
      subject.members << ext_metadata_file2
      subject.members << raster1
      subject.members << raster2
      expect(subject.image_file).to eq image_file1
      expect(subject.metadata_files).to match_array [ext_metadata_file1, ext_metadata_file2]
      expect(subject.raster_works).to match_array [raster1, raster2]
    end
    it 'defines what type of object it is' do
      expect(subject.image_work?).to be_truthy
      expect(subject.image_file?).to be_falsey
      expect(subject.raster_work?).to be_falsey
      expect(subject.raster_file?).to be_falsey
      expect(subject.vector_work?).to be_falsey
      expect(subject.vector_file?).to be_falsey
      expect(subject.external_metadata_file?).to be_falsey
    end
  end

  context 'georeferenced to a raster' do
    subject { FactoryGirl.create(:image_work_with_raster_works, title: ['Test title 4'], coverage: coverage.to_s) }

    it 'aggregates by raster resources' do
      expect(subject.raster_works.size).to eq 1
      expect(subject.raster_works.first).to be_kind_of RasterWork
    end
  end

  describe 'populate_metadata' do
    subject { FactoryGirl.create(:image_work_with_one_metadata_file) }
    let(:doc) { Nokogiri::XML(read_test_data_fixture('McKay/S_566_1914_clip_iso.xml')) }

    it 'has an extraction method' do
      expect(subject).to respond_to(:extract_metadata)
    end

    it 'can perform extraction and set properties for ISO 19139' do
      external_metadata_file = subject.metadata_files.first
      allow(external_metadata_file).to receive(:metadata_xml) { doc }
      allow(external_metadata_file).to receive(:geo_mime_type) { 'application/xml; schema=iso19139' }
      subject.populate_metadata(external_metadata_file.id)
      expect(subject.title).to eq(['S_566_1914_clip.tif'])
    end
  end
end
