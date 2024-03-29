# frozen_string_literal: true

require 'uri'

class AddRepositoryWebhookService
  include Rails.application.routes.url_helpers

  WEBHOOK_EVENTS = ['push'].freeze

  def initialize(repository, client)
    @repository = repository
    @client = client
  end

  def call
    @client.create_hook(
      @repository.full_name,
      'web',
      {
        url: api_checks_url,
        content_type: 'json',
        secret: ENV.fetch('GITHUB_WEBHOOK_SECRET_TOKEN', nil)
      },
      {
        events: WEBHOOK_EVENTS,
        active: true
      }
    )
  end
end
