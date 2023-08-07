# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/repository_check_mailer
class RepositoryCheckMailerPreview < ActionMailer::Preview
  def check_error_email
    @check = Repository::Check.last
    RepositoryCheckMailer.with(check: @check).check_error_email
  end

  def check_offenses_email
    @check = Repository::Check.last
    RepositoryCheckMailer.with(check: @check).check_offenses_email
  end
end
