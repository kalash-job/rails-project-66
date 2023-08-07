# frozen_string_literal: true

require 'test_helper'

class RepositoryCheckMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  setup do
    @check = repository_checks(:one)
    @repository = @check.repository
    @repository_name = @repository.name
  end

  test 'check_error_email' do
    mail = RepositoryCheckMailer.with(check: @check).check_error_email
    mail_text = mail.text_part.decoded
    mail_html = mail.html_part.decoded
    expected_mail_content_values = [@repository_name, @check.id.to_s, repository_url(@repository), root_url]

    assert { mail.subject.include?(@repository_name) }
    assert { mail.to.include?(@repository.user.email) }
    expected_mail_content_values.each do |value|
      assert { mail_text.include?(value) }
      assert { mail_html.include?(value) }
    end
  end

  test 'check_offenses_email' do
    mail = RepositoryCheckMailer.with(check: @check).check_offenses_email
    mail_text = mail.text_part.decoded
    mail_html = mail.html_part.decoded
    expected_mail_content_values = [
      @repository_name,
      @check.id.to_s,
      @check.offenses_count.to_s,
      repository_check_url(@repository, @check),
      root_url
    ]

    assert { mail.subject.include?(@repository_name) }
    assert { mail.to.include?(@repository.user.email) }
    expected_mail_content_values.each do |value|
      assert { mail_text.include?(value) }
      assert { mail_html.include?(value) }
    end
  end
end
