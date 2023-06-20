# frozen_string_literal: true

class FetchRepositoryInfoService
  def initialize(repository)
    @repository = repository
    @client = ApplicationContainer[:octokit_client][repository.user.token]
  end

  def call
    @client.repository(@repository.github_id).tap do |repository_info|
      @repository.update!(
        name: repository_info.name,
        language: repository_info.language || repository_info.parent&.language,
        clone_url: repository_info.clone_url,
        owner_name: repository_info.owner.login
      )
    end
  end
end
