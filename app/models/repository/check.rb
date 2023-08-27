# frozen_string_literal: true

# == Schema Information
#
# Table name: repository_checks
#
#  id             :integer          not null, primary key
#  aasm_state     :string
#  offenses_count :integer          default(0)
#  passed         :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  commit_id      :string
#  repository_id  :integer          not null
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
  include AASM

  belongs_to :repository, inverse_of: :checks, touch: true
  has_many :offenses, class_name: 'Repository::Offense', inverse_of: :check, dependent: :destroy

  aasm whiny_transitions: false do
    state :created, initial: true
    state :checking, :finished, :failed

    event :check do
      transitions from: :created, to: :checking
    end

    event :finish do
      transitions from: :checking, to: :finished
    end

    event :fail do
      transitions from: %i[created checking], to: :failed
    end
  end

  scope :by_id_desc, -> { order(id: :desc) }
end
