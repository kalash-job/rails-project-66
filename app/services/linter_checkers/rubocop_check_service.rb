# frozen_string_literal: true

class LinterCheckers::RubocopCheckService < LinterCheckers::LinterCheckService
  private

  def cmd
    command_options = [
      '.rubocop.yml',
      Rails.root.join('tmp', 'repositories', @repository.github_id.to_s, '**').to_s,
      '--format json'
    ]
    "bundle exec rubocop --config #{command_options.join(' ')}"
  end
end
