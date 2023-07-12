# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @current_user = users(:one)
  end

  test 'should create check for JavaScript repository' do
    sign_in @current_user
    post repository_checks_url @repository
    assert_redirected_to repository_url(@repository)
    @repository.checks.last.tap do |check|
      assert { check.offenses_count == 2 }
    end
  end

  test 'should create check for Ruby repository' do
    sign_in users(:two)
    repository = repositories(:two)
    # TODO: Implement this test after implementing Rubocop checker
    assert_raises NotImplementedError do
      post repository_checks_url repository
      assert_redirected_to repository_url(repository)
    end
  end

  test 'should not create check for another user repository' do
    sign_in users(:two)
    post repository_checks_url @repository
    assert_redirected_to root_url
  end
end
