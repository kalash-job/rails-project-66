# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    user&.id == record.repository.user.id
  end
end
