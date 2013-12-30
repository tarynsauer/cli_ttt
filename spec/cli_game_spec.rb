require 'spec_helper'

describe 'CliGame' do

  context 'gameplay methods' do

    before :each do
      @player_x = ComputerPlayer.new('X')
      @player_o = ComputerPlayer.new('O')
      settings = { :board => CliBoard.new(3),
                 :player_one => @player_x,
                 :player_two => @player_o,
                 :player_first_move => @player_x}
      @game = CliGame.new(settings)
      @game.ui.io = MockKernel
      @player_x.opponent = @player_o
      @player_o.opponent = @player_x
    end

    describe '#play!' do
      it 'exits game when board shows game over' do
        @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'X',
                     "1B"=>'X', "2B"=>'X', "3B"=>'X',
                     "1C"=>'X', "2C"=>'X', "3C"=>'X' }
        @game.play!.should == 'exited'
      end

      it 'plays through game until game over' do
        @game.play!
        @game.ui.io.last_print_call.should include('GAME OVER!')
      end
    end

    describe '#start_game!' do

      it 'plays through game until game over' do
        @game.start_game!
        @game.ui.io.last_print_call.should include('GAME OVER!')
      end
    end

    describe '#get_next_move' do
      it 'calls #request_human_move when current_player is a HumanPlayer' do
        @game.ui.io.set_gets('1B')
        @game.get_next_move
        @game.ui.io.last_print_call.should include("Player 'O': Enter open cell ID")
      end

      it 'calls #invalid_move when human enters bad value' do
        @player_x = HumanPlayer.new('X')
        @player_o = MockPlayer.new('O')
        settings = { :board => CLIBoard.new(3),
                     :player_one => @player_x,
                     :player_two => @player_o,
                     :player_first_move => @player_x }
        @game = CliGame.new(settings)
        @game.ui.io = MockKernel
        @player_x.opponent = @player_o
        @player_o.opponent = @player_x
        @game.ui.io.set_gets('bad_value')
        @game.get_next_move
        @game.ui.io.last_lines(2).should include("not a valid cell ID!")
      end

      it 'calls #make_move when current_player is a ComputerPlayer' do
        @player_x.add_marker(@game.board, '1A')
        @game.get_next_move
        @game.ui.io.last_print_call.should include("Player 'X': Enter open cell ID")
      end
    end

  end

  describe '#invalid_move' do
    before :each do
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      settings = { :board => MockBoard.new,
               :player_one => @player_x,
               :player_two => @player_o,
               :player_first_move => @player_x}
      @game = CliGame.new(settings)
      @game.ui.io = MockKernel
    end

    it "prints taken cell message to screen" do
      @game.invalid_move('3C')
      expect(@game.ui.io.last_print_call).to include('taken')
    end

    it "prints bad cell message to screen" do
      @game.invalid_move('blah!!!')
      expect(@game.ui.io.last_print_call).to include('not a valid cell')
    end
  end

  describe '#exit_game' do
    it "exits the game" do
      @player_x = MockPlayer.new('X')
      settings = { :board => CliBoard.new(3),
                 :player_one => @player_x,
                 :player_two => MockPlayer.new('O'),
                 :player_first_move => @player_x}
      @game = CliGame.new(settings)
      @game.ui.io = MockKernel
      @game.exit_game.should == 'exited'
    end
  end

end