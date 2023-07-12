# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  before_action :authenticate_user!

  def create
    @repository = Repository.find(params[:repository_id])
    authorize @repository, :check?
    @check = @repository.checks.build
    if @check.save
      CheckRepositoryJob.perform_later(@check.id)
      redirect_to repository_path(@repository), notice: t('.success')
    else
      redirect_to repository_path(@repository), alert: t('.failure')
    end
  end
end
