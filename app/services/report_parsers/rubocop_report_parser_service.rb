# frozen_string_literal: true

class ReportParsers::RubocopReportParserService < ReportParsers::LinterReportParserService
  def call(report)
    parsed_report = JSON.parse(report)

    parsed_report['files'].each do |file|
      path = relative_path(file['path'])
      file['offenses'].each do |offense|
        offense_location = offense['location']
        @check.offenses.create(
          path:,
          coords: "#{offense_location['line']}:#{offense_location['column']}",
          message: offense['message'],
          rule_id: offense['cop_name']
        )
      end
    end
    @check.offenses_count = parsed_report['summary']['offense_count']
    @check.passed = @check.offenses_count.zero?
    @check.save
  end
end
