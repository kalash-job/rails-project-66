# frozen_string_literal: true

class ReportParsers::EslintReportParserService < ReportParsers::LinterReportParserService
  def call(report)
    parsed_report = JSON.parse(report)

    offenses_count = 0
    parsed_report.each do |offenses|
      offenses_count += offenses['messages'].size
      path = relative_path(offenses['filePath'])
      offenses['messages'].each do |offense|
        @check.offenses.create(
          path:,
          coords: "#{offense['line']}:#{offense['column']}",
          message: offense['message'],
          rule_id: offense['ruleId']
        )
      end
    end
    @check.offenses_count = offenses_count
    @check.passed = offenses_count.zero?
    @check.save
  end
end
