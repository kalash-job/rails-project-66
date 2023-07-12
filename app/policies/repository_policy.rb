# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def show?
    owner?
  end

  def check?
    owner?
  end

  private

  def owner?
    user&.id == record.user_id
  end
end
