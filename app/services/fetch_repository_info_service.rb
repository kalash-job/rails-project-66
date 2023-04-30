# frozen_string_literal: true

class FetchRepositoryInfoService
  def initialize(repository)
    @repository = repository
    @client = Octokit::Client.new access_token: repository.user.token
  end

  def call
    @client.repository(@repository.github_id).tap do |repository_info|
      @repository.update!(
        name: repository_info.name,
        language: repository_info.language || repository_info.parent&.language
      )
    end
  end
end
