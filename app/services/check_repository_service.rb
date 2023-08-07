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
    begin
      @check.commit_id = @client.commits(@repository.github_id, 'master').first.sha[0...6]
    rescue Octokit::NotFound
      @check.commit_id = @client.commits(@repository.github_id, 'main').first.sha[0...6]
    end
    linter = LINTERS_BY_LANGUAGE.fetch(@repository.language)
    report = LinterCheckers::LinterCheckService
             .create_linter_checker(@check, linter).call
    ReportParsers::LinterReportParserService.create_linter_report_parser(@check, linter).call(report)
    RepositoryCheckMailer.with(check: @check).check_offenses_email.deliver_later if @check.offenses_count.positive?
  end
end
