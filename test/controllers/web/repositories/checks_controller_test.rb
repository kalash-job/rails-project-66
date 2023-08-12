# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @js_repository = repositories(:one)
    @ruby_repository = repositories(:two)
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
    post repository_checks_url @js_repository
    assert_redirected_to repository_url(@js_repository)
    check = @js_repository.checks.last
    assert { check.offenses_count.zero? }
    assert { check.passed }
    assert { check.finished? }
  end

  test 'should create check for Ruby repository' do
    sign_in users(:two)
    post repository_checks_url @ruby_repository
    assert_redirected_to repository_url(@ruby_repository)
    check = @ruby_repository.checks.last
    assert { check.offenses_count == 2 }
    assert { !check.passed }
    assert { check.finished? }
  end

  test 'should not create check for another user repository' do
    sign_in users(:two)
    post repository_checks_url @js_repository
    assert_redirected_to root_url
  end
end
