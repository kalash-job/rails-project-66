# frozen_string_literal: true

require 'uri'

class AddRepositoryWebhookService
  WEBHOOK_PATH = '/api/checks'
  WEBHOOK_EVENTS = ['push'].freeze

  def initialize(repository, client)
    @repository = repository
    @client = client
  end

  def call
    @client.create_hook(
      [@repository.owner_name, @repository.name].join('/'),
      'web',
      {
        url: URI.join(ENV.fetch('BASE_URL', nil), WEBHOOK_PATH).to_s,
        content_type: 'json'
      },
      {
        events: WEBHOOK_EVENTS,
        active: true
      }
    )
  end
end
