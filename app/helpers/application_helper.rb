# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def github_commit_url(repository, commit_id)
    ['https://github.com', repository.owner_name, repository.name, 'commit', commit_id].join('/')
  end

  def github_file_url(repository, commit_id, path)
    ['https://github.com', repository.owner_name, repository.name, 'blob', commit_id, path].join('/')
  end
end
