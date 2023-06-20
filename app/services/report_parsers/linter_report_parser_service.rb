# frozen_string_literal: true

class ReportParsers::LinterReportParserService
  def self.create_linter_report_parser(check, linter)
    parser_service = "ReportParsers::#{linter}ReportParserService"
    Object.const_get(parser_service).new(check)
  end

  def initialize(check)
    @check = check
  end

  def call
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
