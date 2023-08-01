# frozen_string_literal: true

require 'fileutils'

class LinterCheckers::RubocopCheckService < LinterCheckers::LinterCheckService
  private

  def cmd
    config_path = Rails.root.join('config/rubocop/.rubocop.yml').to_s

    command_options = [
      "--config #{config_path}",
      repository_path,
      '--format json'
    ]
    "bundle exec rubocop #{command_options.join(' ')}"
  end
end
