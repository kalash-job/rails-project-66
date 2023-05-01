# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @current_user = users(:one)
  end

  test 'should get index' do
    sign_in @current_user
    get repositories_url
    assert_response :success
  end

  test 'should get show' do
    sign_in @current_user
    get repository_url @repository
    assert_response :success
  end

  test 'should not get show without auth' do
    get repository_url @repository
    assert_redirected_to root_url
  end

  test 'should not get show with wrong user' do
    sign_in users(:two)
    get repository_url @repository
    assert_redirected_to root_url
  end

  test 'should get new' do
    sign_in @current_user
    link_repos = 'https://api.github.com/user/repos?per_page=100'
    stub_request(:get, link_repos)
      .to_return({
                   body: load_fixture('files/repo_list.json'),
                   status: 200,
                   headers: { 'Content-Type' => 'application/json' }
                 })

    link_repositories = 'https://api.github.com/repositories/634347931'
    stub_request(:get, link_repositories)
      .to_return({
                   body: load_fixture('files/repo_parent.json'),
                   status: 200,
                   headers: { 'Content-Type' => 'application/json' }
                 })

    get new_repository_url
    assert_response :success
  end

  test 'should create repository' do
    sign_in @current_user
    attributes = { github_id: Faker::Number.number(digits: 9) }
    post repositories_url params: { repository: attributes }
    repository = @current_user.repositories.find_by(attributes)

    assert { repository }
    assert_redirected_to repositories_url
    assert_enqueued_with(job: FetchRepositoryInfoJob, args: [repository.id]) do
      FetchRepositoryInfoJob.perform_later(repository.id)
    end
  end
end
