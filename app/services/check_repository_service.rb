# frozen_string_literal: true

require 'open3'

class CheckRepositoryService
  LINTERS_BY_LANGUAGE = {
    'Ruby' => 'Rubocop',
    'JavaScript' => 'Eslint'
  }.freeze

  def initialize(check)
    @check = check
    @repository = check.repository
    @client = ApplicationContainer[:octokit_client][@repository.user.token]
  end

  def call
    @check.commit_id = @client.commits(@repository.github_id, 'master').first.sha[0...6]
    report = LinterCheckers::LinterCheckService
             .create_linter_checker(@check, LINTERS_BY_LANGUAGE.fetch(@repository.language)).call
    ReportParsers::LinterReportParserService
      .create_linter_report_parser(@check, LINTERS_BY_LANGUAGE.fetch(@repository.language)).call(report)
  end
end
