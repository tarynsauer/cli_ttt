require 'spec_helper'

describe 'CliBoard' do

  context 'displaying the board grid' do
    before :each do
       @board  = CliBoard.new(3)
       @board.all_cells = {"1A"=>nil, "2A"=>'X', "3A"=>nil,
                          "1B"=>'O', "2B"=>'O', "3B"=>nil,
                          "1C"=>nil, "2C"=>nil, "3C"=>nil}
       @board.io = MockKernel
     end

    describe '#print_board_numbers' do
      it "prints numbers for each row on the board" do
        @board.print_board_numbers
        @board.io.last_lines(5).should include("1", "2", "3")
      end
    end

    describe '#print_divider' do
      it "prints divider below each row on the board" do
        @board.print_divider
        @board.io.last_lines(4).should include("------------------")
      end
    end

    describe '#show_row' do
      it "prints row with a marker present" do
        cells = ['1A', '2A', '3A']
        @board.show_row('A', cells)
        @board.io.last_lines(9).should include("  |     |  X  |  ")
      end

      it "prints row blank row" do
        cells = ['1B', '2B', '3B']
        @board.show_row('A', cells)
        @board.io.last_lines(9).should include("  |  O  |  O  |  ")
      end

      it "prints row with two markers present" do
        cells = ['1C', '2C', '3C']
        @board.show_row('A', cells)
        @board.io.last_lines(9).should include("  |     |     |  ")
      end
    end

    describe '#display_board' do
      it "calls print_board_numbers twice" do
        @board.display_board
        @board.io.last_lines(35).should include("1", "2", "3")
      end

      it "calls print_board_rows once" do
        @board.display_board
        @board.io.last_lines(35).should include("A", "B", "C")
      end
    end

  end

end