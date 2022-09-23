# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Describes methods for printig info to terminal
module Display
  def clear
    puts "\e[H\e[2J"
  end

  def difficulty_selection_message(number)
    puts "Select player #{number}(#{@mark}) computer difficulty:\n1.- Easy\n2.- Medium\n3.- Hard"
  end

  def draw_message(score)
    # clear
    puts score.board
    puts 'Draw game!'
    score.draws += 1
  end

  def goodbye_message
    clear
    puts @score
    puts 'Come again soon!'
    exit(0)
  end

  def invalid_input_message
    puts 'Invalid input, please try again'
  end

  def last_menu_message
    puts @score
    puts "Do you want to play another game?\n[Y/N]\n"
  end

  def player_select_message(number)
    case number
    when 1
      mark = 'X'
    when 2
      mark = 'O'
    end
    puts "Select player #{number}(#{mark}):\n1.- Human\n2.- Computer"
  end

  def play_message(board)
    puts "Player #{@number}(#{@mark}) turn, enter the number of the position you want to place your mark on:"
    puts board
  end

  def retry_input(message, method)
    clear
    invalid_input_message
    message.call
    method.call(gets.chomp)
  end

  def retry_input_with_object(message, method, object)
    clear
    invalid_input_message
    message.call(object)
    method.call(gets.chomp, object)
  end

  def selected_players_message
    clear
    puts 'Players selected:'
    puts @first_player
    puts @second_player
  end

  def victory_message(score)
    clear
    puts score.board
    puts "Congratulations! player #{@number}(#{@mark}) is the winner of this round!"
    @score += 1
  end
end
