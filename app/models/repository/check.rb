# frozen_string_literal: true

# == Schema Information
#
# Table name: repository_checks
#
#  id            :integer          not null, primary key
#  passed        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  commit_id     :integer
#  repository_id :integer          not null
#
# Indexes
#
#  index_repository_checks_on_repository_id  (repository_id)
#
# Foreign Keys
#
#  repository_id  (repository_id => repositories.id)
#
class Repository::Check < ApplicationRecord
  belongs_to :repository, inverse_of: :checks
end
