# frozen_string_literal: true

# == Schema Information
#
# Table name: repository_offenses
#
#  id         :integer          not null, primary key
#  coords     :string
#  message    :string
#  path       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  check_id   :integer          not null
#  rule_id    :string
#
# Indexes
#
#  index_repository_offenses_on_check_id  (check_id)
#
# Foreign Keys
#
#  check_id  (check_id => repository_checks.id)
#
class Repository::Offense < ApplicationRecord
  belongs_to :check, class_name: 'Repository::Check', inverse_of: :offenses
end
