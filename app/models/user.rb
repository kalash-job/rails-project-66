# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nickname   :string
#  email      :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :repositories, inverse_of: :user, dependent: :destroy
end
