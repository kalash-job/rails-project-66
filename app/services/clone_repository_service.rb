# frozen_string_literal: true

class CloneRepositoryService
  def initialize(repository)
    @repository = repository
  end

  def call
    cmd = "git clone #{@repository.clone_url} #{Rails.root.join('tmp', 'repositories', @repository.github_id.to_s)}"
    open3 = ApplicationContainer[:open3][cmd]
    open3.popen3(cmd) do |_stdin, _stdout, stderr, wait_thr|
      unless wait_thr.value.success?
        raise "Error: #{stderr.read}"
      end
    end
  end
end
