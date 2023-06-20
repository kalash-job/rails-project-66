# frozen_string_literal: true

class ReportParsers::RubocopReportParserService < ReportParsers::LinterReportParserService
  def call
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
