# frozen_string_literal: true

class LinterCheckers::LinterCheckService
  def self.create_linter_checker(check, linter)
    linter_service = "LinterCheckers::#{linter}CheckService"
    Object.const_get(linter_service).new(check)
  end

  def initialize(check)
    @check = check
    @repository = check.repository
  end

  def call
    # prepare_config
    open3 = ApplicationContainer[:open3][cmd]
    open3.popen3(cmd) { |_stdin, stdout, _stderr, _wait_thr| stdout.read }
  end

  private

  def cmd
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def repository_path
    [Rails.root.to_s, File.join(Dir.tmpdir, 'repositories', @repository.github_id.to_s)].join
  end
end
