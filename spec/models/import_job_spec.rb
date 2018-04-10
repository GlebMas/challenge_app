require 'rails_helper'

RSpec.describe ImportJob, type: :model do
  let!(:job) { create(:import_job) }

  context 'storing provided file' do
    it 'does not include Rails.root to a filepath' do
      expect(job.filepath).to_not include(Rails.root.to_s)
    end
  end

  context 'while importing process' do
    def build_file(fixture_name)
      original_path = Rails.root.join("spec/fixtures/#{fixture_name}.csv")
      destination = "/tmp/#{fixture_name}.csv"
      FileUtils.cp(original_path, destination)
      Rack::Test::UploadedFile.new(destination)
    end

    let(:sku_file) { build_file('sku') }
    let(:suppliers_file) { build_file('suppliers') }

    let(:sku_job) { create(:import_job, file: sku_file) }
    let(:suppliers_job) { create(:import_job, file: suppliers_file) }

    it 'commits product data' do
      expect {
        sku_job.import
      }.to change {
        Product.count
      }
    end

    it 'commits suppliers data' do
      expect {
        suppliers_job.import
      }.to change {
        Supplier.count
      }
    end
  end
end