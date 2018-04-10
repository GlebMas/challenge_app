# == Schema Information
#
# Table name: import_jobs
#
#  id         :integer          not null, primary key
#  filepath   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImportJob < ApplicationRecord
  WORKING_DIR = Pathname.new('tmp/imports')
  BATCH_SIZE = 500.freeze

  PRODUCT_IMPORT_KEYS = %i(
    sku
    supplier_code
    name
    additional_field_1
    additional_field_2
    additional_field_3
    additional_field_4
    additional_field_5
    price
  ).freeze

  SUPPLIER_IMPORT_KEYS = %i(
    code
    name
  ).freeze

  def file=(file)
    relative_dir_path = WORKING_DIR.join(SecureRandom.hex(5))
    absolute_dir_path = Rails.root.join(relative_dir_path)
    relative_file_path = relative_dir_path.join(file.original_filename)
    absolute_file_path = absolute_dir_path.join(file.original_filename)
    FileUtils.mkdir_p(absolute_dir_path)
    self.filepath = relative_file_path
    FileUtils.cp(file.path, absolute_file_path)
  end

  def file
    File.open(Rails.root.join(filepath))
  end

  def import
    ActiveRecord::Base.transaction do
      CSV.open(self.filepath, col_sep: '¦').each_slice(BATCH_SIZE) do |rows|
        @rows = rows
        commit_data
      end
    end
  end

  def commit_data
    filename = File.basename(filepath, '.*')

    case filename
    when 'suppliers'
      commit_supplier_data
    when 'sku'
      commit_product_data
    else
      raise NotImplementedError
    end
  end

  def commit_product_data
    Product.import(
      PRODUCT_IMPORT_KEYS,
      @rows,
      on_duplicate_key_update: {
        conflict_target: [:sku],
        columns: PRODUCT_IMPORT_KEYS
      },
      validate: true
    )
  end

  def commit_supplier_data
    Supplier.import(
      SUPPLIER_IMPORT_KEYS,
      @rows,
      on_duplicate_key_update: {
        conflict_target: [:code],
        columns: SUPPLIER_IMPORT_KEYS
      },
      validate: true
    )
  end
end
