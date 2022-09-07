# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Player object class
class Player
  require_relative 'retry_pick'
  include RetryPick
  attr_reader :type, :score

  def initialize(number)
    @number = number
    @mark = pick_mark(number)
    @type = select_player
    @score = 0
  end

  def play_message(board)
    puts "Player #{@number}(#{@mark}) turn, enter the number of the position you want to place your mark on:"
    puts board
  end

  def play(input, board)
    if ('1'..'9').include?(input) && board.mark_placed?(input)
      board.place(input, @mark)
    elsif ('1'..'9').include?(input)
      puts 'The chosen position is already marked'
      retry_play(method(:play_message), method(:play), board)
    else
      retry_play(method(:play_message), method(:play), board)
    end
  end

  def victory_message
    puts "\e[H\e[2J"
    puts @board
    puts "Congratulations! player #{@number}(#{@mark}) is the winner of this round!"
    @score += 1
  end

  private

  def player_request_message
    puts "Select player #{@number}(#{@mark}):\n1.- Human\n2.- Computer"
  end

  def difficulty_request_message
    puts "Select player #{@number}(#{@mark}) computer difficulty:\n1.- Easy\n2.- Medium\n3.- Hard"
  end

  def select_difficulty(input)
    case input
    when '1'

      'easy'

    when '2'

      'medium'

    when '3'

      'hard'
    else
      retry_selection(method(:difficulty_request_message), method(:select_difficulty))
    end
  end

  def select_type(input)
    case input
    when '1'

      'human'

    when '2'

      difficulty_request_message
      @difficulty = select_difficulty(gets.chomp)
      'computer'

    else
      retry_selection(method(:player_request_message), method(:select_type))
    end
  end

  def select_player
    puts "\e[H\e[2J"
    player_request_message
    @type = select_type(gets.chomp)
  end

  def pick_mark(number)
    case number
    when 1
      'X'
    when 2
      'O'
    end
  end

  def to_s
    case @type
    when 'human'
      "Player #{@number}: human, marks #{@mark}"
    when 'computer'
      "Player #{@number}: computer, #{@difficulty} difficulty, marks #{@mark}"
    end
  end
end
