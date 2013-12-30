File.join(File.expand_path(File.dirname(__FILE__)), "..", "lib")
require 'ruby_ttt'

setup = CLIGameSetup.new
settings = setup.get_settings
CLIGame.new(settings).start_game!