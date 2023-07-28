# frozen_string_literal: true

class Api::ChecksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      repository = Repository.find_by!(github_id: params[:repository][:id])
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error(e)
      head :unprocessable_entity and return
    end

    @check = repository.checks.build
    if @check.save
      CheckRepositoryJob.perform_later(@check.id)
      head :ok
    else
      Rails.logger.error(@check.errors.full_messages)
      head :unprocessable_entity
    end
  end
end
