# frozen_string_literal: true

require 'open3'

class ApplicationContainer
  extend Dry::Container::Mixin

  register(:octokit_client) do |user_token|
    if Rails.env.test?
      OctokitClientStub.new
    else
      Octokit::Client.new(access_token: user_token, auto_paginate: true)
    end
  end

  register(:open3) do |cmd|
    if Rails.env.test?
      Open3Stub.new(cmd)
    else
      Open3
    end
  end
end
