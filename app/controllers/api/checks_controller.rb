# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  # Uncomment this line to enable GitHub webhook token verification
  # before_action :check_github_webhook_token

  def create
    begin
      repository = Repository.find_by!(github_id: params[:repository][:id])
    rescue ActiveRecord::RecordNotFound => e
      process_error(e)
    end

    @check = repository.checks.build
    if @check.save
      CheckRepositoryJob.perform_later(@check.id)
      head :ok
    else
      process_error(@check.errors.full_messages)
    end
  end

  private

  def check_github_webhook_token
    signature = request.headers.fetch('X-Hub-Signature-256', nil)
    payload_body = request.body.read
    return head :bad_request unless signature.presence && payload_body.presence

    token = ENV.fetch('GITHUB_WEBHOOK_SECRET_TOKEN', nil)
    expected_signature = "sha256=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), token, payload_body)}"

    head :unauthorized unless ActiveSupport::SecurityUtils.secure_compare(signature, expected_signature)
  end

  def process_error(error)
    Rails.logger.error(error)
    head :unprocessable_entity
  end
end
