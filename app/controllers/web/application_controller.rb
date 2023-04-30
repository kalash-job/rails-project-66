# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthConcern

  private

  def authenticate_user!
    return if signed_in?

    redirect_to root_path, alert: t('layouts.web.flash.non_authenticated_user')
  end
end
