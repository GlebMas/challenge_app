FactoryBot.define do
  factory :import_job, class: 'ImportJob' do
    file do
      original = filepath || Rails.root.join('spec/fixtures/sku.csv')
      destination = '/tmp/sku.csv'
      FileUtils.cp(original, destination)
      Rack::Test::UploadedFile.new(destination)
    end
  end
end