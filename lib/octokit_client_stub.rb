# frozen_string_literal: true

class OctokitClientStub
  Repo = Struct.new(:name, :id, :language)

  def repos
    [
      Repo.new('test1', 1, 'JavaScript'),
      Repo.new('test2', 2, 'PHP'),
      Repo.new('test3', 3, 'Ruby'),
      Repo.new('test4', 4, nil)
    ]
  end

  Repository = Struct.new(:parent, :language, :name)

  def repository(_)
    Repository.new(
      Repository.new(nil, 'JavaScript', 'test2'),
      'JavaScript',
      'test1'
    )
  end
end
