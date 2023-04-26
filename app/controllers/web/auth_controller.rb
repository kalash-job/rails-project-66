# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    email = auth[:info][:email].downcase
    nickname = auth[:info][:nickname]
    token = auth[:credentials][:token]
    user = User.find_or_initialize_by(email:)
    user.nickname = nickname
    user.token = token
    if user.save
      sign_in(user)
      flash[:success] = t('.success')
    else
      flash[:failure] = t('.failure')
    end
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
