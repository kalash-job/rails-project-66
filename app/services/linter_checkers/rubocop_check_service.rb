# frozen_string_literal: true

class LinterCheckers::RubocopCheckService < LinterCheckers::LinterCheckService
  def call
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
