class CreateImportJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :import_jobs do |t|
      t.string :filepath

      t.timestamps
    end
  end
end
