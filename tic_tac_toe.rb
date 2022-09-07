# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Game object class
class TicTacToe
  require_relative 'player'
  require_relative 'board'
  require_relative 'retry_pick'
  include RetryPick

  def initialize
    @first_player = Player.new(1)
    @second_player = Player.new(2)
    selected_players_message
    @draws = 0
    @board = Board.new
    start_game
  end

  private

  def selected_players_message
    puts "\e[H\e[2J"
    puts 'Players selected:'
    puts @first_player
    puts @second_player
  end

  def draw_message
    puts "\e[H\e[2J"
    puts @board
    puts 'Draw game!'
    @draws += 1
  end

  def last_menu_message
    puts "Do you want to play another game?\n[Y/N]\n"
  end

  def score
    puts 'Score:'
    puts "Player 1(X) #{@first_player.score} - #{@second_player.score} Player 2(O)"
    puts "Draws: #{@draws}"
  end

  def play_again
    @board = Board.new
    start_game
  end

  def pick_last_menu(input)
    case input.upcase
    when 'Y'
      play_again
    when 'N'
      puts 'Come again soon!'
      exit(0)
    else
      retry_selection(method(:last_menu_message), method(:pick_last_menu))
    end
  end

  def last_menu
    last_menu_message
    pick_last_menu(gets.chomp)
  end

  def pick_victor(mark)
    case mark
    when 'X'
      @first_player.victory_message
    when 'O'
      @second_player.victory_message
    when 'DRAW'
      draw_message
    end
  end

  def turn(player)
    case player.type
    when 'human'
      # puts "\e[H\e[2J"
      player.play_message(@board)
      player.play(gets.chomp, @board)
    when 'computer'
      # something_else
      puts 'computer action'
    end
    pick_victor(@board.check_stalemate)
  end

  def start_game
    [@first_player, @second_player].each { |player| turn(player) } until @board.game_over
    score
    last_menu
  end
end

TicTacToe.new
