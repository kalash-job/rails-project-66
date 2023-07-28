# frozen_string_literal: true

class ProcessNewRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)
    client = ApplicationContainer[:octokit_client][repository.user.token]
    FetchRepositoryInfoService.new(repository, client).call
    AddRepositoryWebhookService.new(repository, client).call
  end
end
