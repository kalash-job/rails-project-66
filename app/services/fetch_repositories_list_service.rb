# frozen_string_literal: true

class FetchRepositoriesListService
  def initialize(user_token)
    @client = ApplicationContainer[:octokit_client][user_token]
    @cache_key = "repositories_list_#{user_token}"
  end

  def call
    Rails.cache.fetch(@cache_key, expires_in: 1.hour) do
      languages = Repository.language.values.collect(&:text)
      repositories = @client.repos.select do |repository|
        repository_language = repository.language || @client.repository(repository.id).parent&.language
        repository_language.present? && languages.include?(repository_language.downcase)
      end
      { repos: repositories.pluck(:name, :id), caching_time: Time.now.to_i }
    end
  end
end
