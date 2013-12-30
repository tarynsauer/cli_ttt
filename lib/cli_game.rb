require 'ruby_ttt'

class CliGame < Game
  attr_accessor :board, :player_one, :player_two, :ui, :player_first_move
  def initialize(settings)
    super
    @ui = CliUI.new
  end

  def start_game!
    begin
      play!
    rescue Interrupt
      ui.early_exit_message
      exit
    end
  end

  def play!
    ui.first_move_message(current_player.marker)
    until board.game_over?
      board.display_board
      get_next_move
    end
    exit_game
  end

  def get_next_move
    if current_player.is_a?(HumanPlayer)
      move = ui.request_human_move
      verify_move(move) ? advance_game : invalid_move(move)
    else
      current_player.make_move(board)
      advance_game
    end
  end

  def invalid_move(cell)
    board.valid_cell?(cell) ? ui.taken_cell_message(cell) : ui.bad_cell_message(cell)
  end

  def exit_game
    board.display_board
    ui.io.exit
  end

end