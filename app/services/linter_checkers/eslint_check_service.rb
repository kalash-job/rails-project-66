# frozen_string_literal: true

class LinterCheckers::EslintCheckService < LinterCheckers::LinterCheckService
  def cmd
    command_options = [
      '--no-eslintrc',
      '--format json'
    ]

    "eslint #{Rails.root.join('tmp', 'repositories', @repository.github_id.to_s)} #{command_options.join(' ')}"
  end
end
