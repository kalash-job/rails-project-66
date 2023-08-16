# frozen_string_literal: true

class ReportParsers::LinterReportParserService
  PATH_NESTING_LEVEL = 2
  def self.create_parser(check, linter)
    parser_service = "ReportParsers::#{linter}ReportParserService"
    Object.const_get(parser_service).new(check)
  end

  def initialize(check)
    @check = check
  end

  def call(_report)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  private

  def relative_path(path)
    path_elements = path.split('/')
    path_elements.drop(path_elements.index('repositories') + PATH_NESTING_LEVEL).join('/')
  end
end
