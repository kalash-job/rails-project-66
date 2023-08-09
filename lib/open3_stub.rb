# frozen_string_literal: true

class Open3Stub
  ActiveRecord::FixtureSet.create_fixtures('test/fixtures', %i[repositories])

  GIT_COMMAND_BEGINNING = 'git'
  ESLINT_COMMAND_BEGINNING = 'eslint'
  RUBOCOP_COMMAND_BEGINNING = 'bundle'

  def initialize(cmd)
    @cmd = cmd
  end

  def popen3(_cmd)
    fake_rubocop_json = File.read('test/fixtures/files/fake_rubocop_output.json')
    empty_string = ''
    empty_array = []

    command_beginning = @cmd.split.first
    case command_beginning
    when GIT_COMMAND_BEGINNING then empty_string
    when ESLINT_COMMAND_BEGINNING then empty_array.to_json
    when RUBOCOP_COMMAND_BEGINNING then fake_rubocop_json
    else
      raise "Unexpected command: #{cmd}"
    end
  end
end
