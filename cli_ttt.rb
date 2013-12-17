require 'ruby_ttt'

board = Board.new(3)
player_one = Player.new(MARKER_X)
player_two = Player.new(MARKER_O)
CLIGame.new(board, player_one, player_two).start_cli_game!