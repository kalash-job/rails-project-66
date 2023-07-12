# frozen_string_literal: true

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
    linter = LINTERS_BY_LANGUAGE.fetch(@repository.language)
    report = LinterCheckers::LinterCheckService
             .create_linter_checker(@check, linter).call
    ReportParsers::LinterReportParserService.create_linter_report_parser(@check, linter).call(report)
  end
end
