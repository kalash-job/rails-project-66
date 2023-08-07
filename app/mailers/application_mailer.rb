# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV.fetch('NOREPLY_EMAIL_LOGIN', nil)}@#{ENV.fetch('APP_HOST', nil)}"
  layout 'mailer'
end
