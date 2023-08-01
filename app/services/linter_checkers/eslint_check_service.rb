# frozen_string_literal: true

class LinterCheckers::EslintCheckService < LinterCheckers::LinterCheckService
  private

  def cmd
    command_options = [
      repository_path,
      '--no-eslintrc',
      '-c .eslintrc.js',
      '--format json'
    ]

    "eslint #{command_options.join(' ')}"
  end
end
