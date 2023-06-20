# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def create
    @repository = Repository.find(params[:repository_id])
    @check = @repository.checks.build
    if @check.save
      CheckRepositoryJob.perform_later(@check.id)
      redirect_to repository_path(@repository), notice: t('.success')
    else
      redirect_to repository_path(@repository), alert: t('.failure')
    end
  end
end
