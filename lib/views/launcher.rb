# frozen_string_literal: true

# Game launcher & management
class Launcher
  attr_accessor :player1, :player2

  def initialize
    register_players
    greet_players
    @grid = Grid.new
    rounds
  end

  def register_players
    print SEPARATOR
    name_query = ", quel est ton nom ?\n"
    wrong_choice = 'Mauvais choix:'
    re_register = "\nOn recommence.\n\n"

    print("Joueur 1#{name_query}#{PROMPT}")
    p1_name = gets.chomp

    print("#{SPACER}Joueur 2#{name_query}#{PROMPT}")
    p2_name = gets.chomp

    if p1_name == p2_name
      print("#{wrong_choice} vos noms doivent être différents. #{re_register}".red)
      register_players
    elsif p1_name.empty? || p2_name.empty?
      print("#{wrong_choice} Il y a eu une question sans réponse. #{re_register}".red)
      register_players
    else
      @player1 = Players.new(p1_name.bold.yellow, 'X'.bold.yellow)
      @player2 = Players.new(p2_name.bold.magenta, 'O'.bold.magenta)
      print SEPARATOR
    end
  end

  def greet_players
    print(
      'Bienvenue, ', @player1.name, ', ton symbole est le ', @player1.symbol, ".\n",
      'À toi aussi, ', @player2.name, ', ton symbole est ', @player2.symbol, ".\n"
    )
  end

  # TODO: Not implemented
  # Randomize the first player
  # def first_blood
  #   print("On tire un dé à 20 faces pour savoir qui commence !\n")
  #   p1_dice = rand(0..20)
  #   p2_dice = rand(0..20)
  #   if p1_dice == p2_dice
  #     print("Même chiffre ! #{p1_dice}\n")
  #   else
  #     print("#{@player1.name}: #{p1_dice}\n#{@player2.name}: #{p2_dice}\n")
  #   end
  #   prio = if p1_dice > p2_dice
  #            @player1
  #          else
  #            @player2
  #          end
  #   last = @player2
  # end

  # No terminal clear because I don’t like them
  def rounds
    loop do
      print SEPARATOR
      @grid.show_grid
      @grid.turn(@player1)
      if @grid.still_going?(@player1) == false # Check winning condition
        @grid.show_grid
        break
      end
      @grid.show_grid # Not an error, should show a grid between players’ rounds

      @grid.turn(@player2)
      if @grid.still_going?(@player2) == false
        @grid.show_grid
        break
      end
    end
    replay?
  end

  def replay?
    print("On rejoue (y/n)?\n#{PROMPT}")
    choice = gets.chomp

    case choice
    when 'y'
      print("C'est reparti !\n")
      initialize
    when 'n'
      print("À la prochaine !\n")
    else
      print("Une réponse valide serait appréciée !\n")
      replay?
    end
  end
end
