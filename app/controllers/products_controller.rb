class ProductsController < ApplicationController
  respond_to :html

  def index
    respond_with collection
  end

  def import
    job = ImportJob.create(file: params[:file])
    Import::Jobs::ImportData.new(job.id).enqueue
    head :ok
  end

  def collection
    @products ||= Product.
      preload(:supplier).
      order(:name).
      page(params[:page]).
      all
  end
end