# frozen_string_literal: true

# == Schema Information
#
# Table name: repositories
#
#  id         :integer          not null, primary key
#  language   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  github_id  :integer
#  user_id    :integer          not null
#
# Indexes
#
#  index_repositories_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user, inverse_of: :repositories

  validates :github_id, presence: true

  enumerize :language, in: %i[JavaScript Ruby], scope: true
end
