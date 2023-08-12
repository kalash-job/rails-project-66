# frozen_string_literal: true

# == Schema Information
#
# Table name: repositories
#
#  id         :integer          not null, primary key
#  clone_url  :string
#  full_name  :string
#  language   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  github_id  :integer
#  user_id    :integer          not null
#
# Indexes
#
#  index_repositories_on_github_id  (github_id) UNIQUE
#  index_repositories_on_user_id    (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user, inverse_of: :repositories
  has_many :checks, class_name: 'Repository::Check', inverse_of: :repository, dependent: :destroy

  validates :github_id, presence: true
  validates :github_id, uniqueness: true

  enumerize :language, in: %i[javascript ruby], scope: true

  scope :by_id, -> { order(:id) }
end
