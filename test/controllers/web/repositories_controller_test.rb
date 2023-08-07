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
    get new_repository_url
    assert_response :success
  end

  test 'should create repository' do
    sign_in @current_user
    attributes = { github_id: Faker::Number.number(digits: 9) }
    post repositories_url params: { repository: attributes }
    search_attributes = attributes.merge(clone_url: 'https://github.com/test/test.js.git')
    repository = @current_user.repositories.find_by(search_attributes)

    assert { repository }
    assert_redirected_to repositories_url
  end

  test 'should invalidate cache' do
    sign_in @current_user
    cache_key = "repositories_list_#{@current_user.token}"
    mock_delete = Minitest::Mock.new
    mock_delete.expect(:call, true, [cache_key])
    Rails.cache.stub(:delete, mock_delete) do
      post invalidate_cache_repositories_url
      assert_redirected_to new_repository_url
    end
    mock_delete.verify
  end
end
