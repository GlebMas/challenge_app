class Import::Jobs::ImportData < ApplicationJob
  queue_as :import

  def perform(job_id)
    job = ImportJob.find(job_id)
    job.import
  end
end