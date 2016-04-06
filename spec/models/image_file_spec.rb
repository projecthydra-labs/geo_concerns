require 'spec_helper'

describe FileSet do
  let(:user) { create(:user) }
  subject { described_class.new(mime_type: 'image/jpeg') }

  context "when conforms_to is an image format" do
    it "responds as an image file" do
      expect(subject.image_file?).to be_truthy
    end
    it "doesn't respond as a vector file" do
      expect(subject.vector_file?).to be_falsey
    end
    it 'does not have an authoritative cartographic projection' do
      # expect(subject).not_to respond_to(:cartographic_projection)
      skip 'Our models for FileSet always include cartographic_projection'
    end
  end

  describe 'image work association' do
    let(:work) { FactoryGirl.create(:image_work_with_one_file) }
    subject { work.file_sets.first.reload }
    it 'belongs to image work' do
      expect(subject.image_work).to eq [work]
    end
  end

  describe "to_solr" do
    let(:solr_doc) { FactoryGirl.build(:vector_file,
                                       date_uploaded: Time.zone.today,
                                       cartographic_projection: 'urn:ogc:def:crs:EPSG::6326').to_solr
    }

    it "indexes the coordinate reference system" do
      expect(solr_doc.keys).to include 'cartographic_projection_tesim'
    end
  end

  describe 'metadata' do
    it 'has descriptive metadata' do
      expect(subject).to respond_to(:title)
    end

    it 'has standard' do
      expect(subject).to respond_to(:conforms_to)
    end
  end
end
