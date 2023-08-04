# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_github_webhook_token

  def create
    begin
      repository = Repository.find_by!(github_id: params[:repository][:id])
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error(e)
      head :unprocessable_entity
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

  private

  def check_github_webhook_token
    signature = request.headers.fetch('X-Hub-Signature-256', nil)
    payload_body = request.body.read
    return head :bad_request if signature.nil? || payload_body.nil?

    token = ENV.fetch('GITHUB_WEBHOOK_SECRET_TOKEN', nil)
    expected_signature = "sha256=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), token, payload_body)}"

    head :unauthorized unless ActiveSupport::SecurityUtils.secure_compare(signature, expected_signature)
  end
end
