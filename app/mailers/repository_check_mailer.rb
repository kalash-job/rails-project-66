# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def check_error_email
    @check = params[:check]
    @repository = @check.repository
    @user = @repository.user
    @repository_url = repository_url(@repository)
    @root_url = root_url
    mail(to: @user.email, subject: t('.subject', repository_name: @repository.name))
  end

  def check_offenses_email
    @check = params[:check]
    @repository = @check.repository
    @user = @repository.user
    @check_url = repository_check_url(@repository, @check)
    @root_url = root_url
    mail(to: @user.email, subject: t('.subject', repository_name: @repository.name))
  end
end
