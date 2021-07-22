# frozen_string_literal: true

# This class handles the state of the game grid
class Grid
  attr_accessor :grid, :a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3

  def initialize
    generate_cells
  end

  def generate_cells
    @a1 = Cells.new('A1', ' ')
    @a2 = Cells.new('A2', ' ')
    @a3 = Cells.new('A3', ' ')
    @b1 = Cells.new('B1', ' ')
    @b2 = Cells.new('B2', ' ')
    @b3 = Cells.new('B3', ' ')
    @c1 = Cells.new('C1', ' ')
    @c2 = Cells.new('C2', ' ')
    @c3 = Cells.new('C3', ' ')
  end

  def show_grid
    margin = ' ' * 22
    printf(
      "%s    A   B   C\n"      \
      "%s  ╭───┬───┬───╮\n"    \
      "%s1 │ %s │ %s │ %s │\n" \
      "%s  ├───┼───┼───┤\n"    \
      "%s2 │ %s │ %s │ %s │\n" \
      "%s  ├───┼───┼───┤\n"    \
      "%s3 │ %s │ %s │ %s │\n" \
      "%s  ╰───┴───┴───╯\n",
      margin,
      margin,
      margin, @a1.state, @b1.state, @c1.state,
      margin,
      margin, @a2.state, @b2.state, @c2.state,
      margin,
      margin, @a3.state, @b3.state, @c3.state,
      margin
    )
    print SEPARATOR
  end

  def cell_picker(player)
    print("#{player.name}, coche la case que tu veux !\n#{PROMPT}")
    gets.chomp.upcase
  end

  def turn(player)
    choice = cell_picker(player)
    print SPACER
    # We fill the cell only if it’s empty
    if choice == 'A1' && @a1.state == ' '
      @a1.state = player.symbol
    elsif choice == 'A2' && @a2.state == ' '
      @a2.state = player.symbol
    elsif choice == 'A3' && @a3.state == ' '
      @a3.state = player.symbol
    elsif choice == 'B1' && @b1.state == ' '
      @b1.state = player.symbol
    elsif choice == 'B2' && @b2.state == ' '
      @b2.state = player.symbol
    elsif choice == 'B3' && @b3.state == ' '
      @b3.state = player.symbol
    elsif choice == 'C1' && @c1.state == ' '
      @c1.state = player.symbol
    elsif choice == 'C2' && @c2.state == ' '
      @c2.state = player.symbol
    elsif choice == 'C3' && @c3.state == ' '
      @c3.state = player.symbol
    else
      print("la case #{choice} est déja remplie ou n'exite pas !\n")
      turn(player)
    end
  end

  def still_going?(player)
    # oookay: check if a winning combination have a single symbol that isn't ' '
    if (@a1.state != ' ' && [a1.state, @a2.state, @a3.state].uniq.length == 1) || \
       (@b1.state != ' ' && [b1.state, @b2.state, @b3.state].uniq.length == 1) || \
       (@c1.state != ' ' && [c1.state, @c2.state, @c3.state].uniq.length == 1) || \
       (@a1.state != ' ' && [a1.state, @b1.state, @c1.state].uniq.length == 1) || \
       (@a2.state != ' ' && [a2.state, @b2.state, @c2.state].uniq.length == 1) || \
       (@a3.state != ' ' && [a3.state, @b3.state, @c3.state].uniq.length == 1) || \
       (@a1.state != ' ' && [a1.state, @b2.state, @c3.state].uniq.length == 1) || \
       (@a3.state != ' ' && [a3.state, @b2.state, @c1.state].uniq.length == 1)
      print("Bravo #{player.name}, tu as gagné !\n".blue.bold)
      false
    # Is it a draw ? Check if every cells are filled
    elsif [@a1.state, @a2.state, @a3.state, \
           @b1.state, @b2.state, @b3.state, \
           @c1.state, @c2.state, @c3.state].include?(' ') == false
      print("Match nul !\n".red.bold)
      false
    else
      true
    end
  end
end
