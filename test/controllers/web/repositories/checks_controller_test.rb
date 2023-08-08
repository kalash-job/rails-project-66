# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @current_user = users(:one)
  end

  test 'should get show check' do
    sign_in @current_user
    check = repository_checks(:one)
    get repository_check_url check.repository, check
    assert_response :success
  end

  test 'should not get show check without login' do
    check = repository_checks(:one)
    get repository_check_url check.repository, check
    assert_redirected_to root_url
  end

  test 'should create check for JavaScript repository' do
    sign_in @current_user
    post repository_checks_url @repository
    assert_redirected_to repository_url(@repository)
    @repository.checks.last.tap do |check|
      assert { check.offenses_count == 2 }
      assert { !check.passed }
      assert { check.finished? }
    end
  end

  test 'should create check for Ruby repository' do
    sign_in users(:two)
    repository = repositories(:two)
    post repository_checks_url repository
    assert_redirected_to repository_url(repository)
    repository.checks.last.tap do |check|
      assert { check.offenses_count == 2 }
      assert { !check.passed }
      assert { check.finished? }
    end
  end

  test 'should not create check for another user repository' do
    sign_in users(:two)
    post repository_checks_url @repository
    assert_redirected_to root_url
  end
end
