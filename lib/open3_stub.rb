# frozen_string_literal: true

class Open3Stub
  ActiveRecord::FixtureSet.create_fixtures('test/fixtures', %i[repositories])

  GIT_COMMAND_BEGINNING = 'git'
  ESLINT_COMMAND_BEGINNING = 'eslint'
  RUBOCOP_COMMAND_BEGINNING = 'rubocop'

  def initialize(cmd)
    @cmd = cmd
  end

  def popen3(_cmd)
    fake_json = File.read('test/fixtures/files/fake_eslint_output.json')
    empty_string = ''

    command_beginning = @cmd.split.first
    case command_beginning
    when GIT_COMMAND_BEGINNING, RUBOCOP_COMMAND_BEGINNING then empty_string
    when ESLINT_COMMAND_BEGINNING then fake_json
    else
      raise "Unexpected command: #{cmd}"
    end
  end
end
