# frozen_string_literal: true

class FetchRepositoryInfoService
  def initialize(repository, client)
    @repository = repository
    @client = client
  end

  def call
    @client.repository(@repository.github_id).tap do |repository_info|
      @repository.update!(
        name: repository_info.name,
        language: repository_info.language || repository_info.parent&.language,
        clone_url: repository_info.clone_url,
        full_name: [repository_info.owner.login, repository_info.name].join('/')
      )
    end
  end
end
