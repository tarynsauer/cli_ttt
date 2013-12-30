require 'ruby_ttt'

class CliBoard < Board
  attr_accessor :all_cells, :num_of_rows, :winning_lines, :io
  def initialize(num_of_rows)
    super
    @io = Kernel
  end

  def print_board_numbers
    num = 1
    io.print "    "
    num_of_rows.times do
      io.print "--#{num}-- "
      num += 1
    end
    io.print "\n"
  end

  def print_divider
    io.print "   "
    num_of_rows.times { io.print "------" }
    io.print "\n"
  end

  def print_board_rows
    alpha = 'A'
    all_rows.each do |row|
      show_row(alpha, row)
      alpha = alpha.next
    end
  end

  def show_row(letter, cells)
    io.print "#{letter}"
    cells.each { |cell| io.print "  |  " + show_marker(cell) }
    io.print "  | #{letter}\n"
    print_divider
  end

  def show_marker(cell)
    all_cells[cell].nil? ? ' ' : all_cells[cell]
  end

  def display_board
    print_board_numbers
    print_board_rows
    print_board_numbers
  end

end