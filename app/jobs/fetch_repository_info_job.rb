# frozen_string_literal: true

class FetchRepositoryInfoJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)
    FetchRepositoryInfoService.new(repository).call
  end
end
