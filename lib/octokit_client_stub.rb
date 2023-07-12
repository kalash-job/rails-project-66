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

  Repository = Struct.new(:parent, :language, :name, :clone_url, :owner)
  Owner = Struct.new(:login)

  def repository(_)
    Repository.new(
      Repository.new(nil, 'JavaScript', 'test2'),
      'JavaScript',
      'test1',
      'https://github.com/test/test.js.git',
      Owner.new('test')
    )
  end

  Commit = Struct.new(:sha)
  def commits(_, _)
    [Commit.new('79dedc238ec30bc5f7c5ee8005e66c99d42a97f6')]
  end
end
