# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  before_action :authenticate_user!

  def show
    @repository = Repository.find(params[:repository_id])
    @check = @repository.checks.find(params[:id])
    authorize @check
    @offenses = Rails.cache.fetch([@check, 'offenses']) do
      @check.offenses.each_with_object({}) do |offense, acc|
        acc[offense.path] ||= []
        acc[offense.path] << offense
      end
    end
  end

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
