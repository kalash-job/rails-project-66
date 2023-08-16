# frozen_string_literal: true

class ReportParsers::EslintReportParserService < ReportParsers::LinterReportParserService
  def call(report)
    parsed_report = JSON.parse(report)

    parsed_report.each do |offenses|
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
  end
end
