# frozen_string_literal: true

require 'fileutils'

class LinterCheckers::RubocopCheckService < LinterCheckers::LinterCheckService
  private

  def cmd
    command_options = [
      config_path,
      [Rails.root.to_s, File.join(Dir.tmpdir, 'repositories', @repository.github_id.to_s)].join,
      '--format json'
    ]
    "bundle exec rubocop --config #{command_options.join(' ')}"
  end

  def prepare_config
    FileUtils.cp_r('.rubocop.yml', config_path, remove_destination: true)
  end

  def config_path
    [Rails.root.to_s, File.join(Dir.tmpdir, 'repositories', @repository.github_id.to_s, '.rubocop.yml')].join
  end
end
