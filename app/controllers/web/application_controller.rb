# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthConcern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Octokit::Error, with: :can_not_get_github_data

  private

  def authenticate_user!
    return if signed_in?

    redirect_to root_path, alert: t('layouts.web.flash.non_authenticated_user')
  end

  def user_not_authorized
    redirect_to root_path, alert: t('layouts.web.flash.not_authorized')
  end

  def can_not_get_github_data
    redirect_to root_path, alert: t('layouts.web.flash.can_not_get_github_data')
  end
end
