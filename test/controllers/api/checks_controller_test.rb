# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'add new check after push webhook' do
    repository = repositories(:one)
    params = {
      repository: {
        id: repository.github_id
      }
    }
    payload_body = "repository[id]=#{repository.github_id}"
    token = ENV.fetch('GITHUB_WEBHOOK_SECRET_TOKEN', nil)
    x_hub_signature_header = "sha256=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), token, payload_body)}"
    previous_checks_count = Repository::Check.count
    post api_checks_url,
         params:,
         headers: { 'X-Hub-Signature-256' => x_hub_signature_header }

    assert { previous_checks_count + 1 == Repository::Check.count }
    assert { Repository::Check.last.finished? }
    assert_response :success
  end
end
