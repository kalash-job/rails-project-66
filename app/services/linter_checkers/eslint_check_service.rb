# frozen_string_literal: true

class LinterCheckers::EslintCheckService < LinterCheckers::LinterCheckService
  private

  def cmd
    command_options = [
      '--no-eslintrc',
      '-c .eslintrc.js',
      '--format json'
    ]

    "eslint #{Rails.root.join('tmp', 'repositories', @repository.github_id.to_s)} #{command_options.join(' ')}"
  end

  def prepare_config; end
end
