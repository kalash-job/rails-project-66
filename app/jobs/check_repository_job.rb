# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    @check.fail!
    clean_repositories_directory
    raise exception
  end

  def perform(check_id)
    @check = Repository::Check.find(check_id)
    @check.check!
    CloneRepositoryService.new(@check.repository).call
    CheckRepositoryService.new(@check).call
    clean_repositories_directory
    @check.finish!
  end

  private

  def clean_repositories_directory
    FileUtils.rm_rf(Rails.root.join('tmp/repositories'))
  end
end
