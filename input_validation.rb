# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Describes methods for input validation
module InputValidation
  def difficulty_selection(input, number)
    case input
    when '1'

      ComputerEasy.new(number)

    when '2'

      ComputerMedium.new(number)

    when '3'

      ComputerHard.new(number)
    else
      retry_input_with_object(method(:difficulty_selection_message), method(:difficulty_selection), number)
    end
  end

  def last_menu_selection(input)
    case input.upcase
    when 'Y'
      play_again
    when 'N'
      goodbye_message
    else
      retry_input(method(:last_menu_message), method(:last_menu_selection))
    end
  end

  def play(input, board)
    if ('1'..'9').include?(input) && board.marked_in?(input)
      board.place(input, @mark)
    elsif ('1'..'9').include?(input)
      retry_input_with_object(method(:play_message), method(:play), board)
    else
      retry_input_with_object(method(:play_message), method(:play), board)
    end
  end

  def player_selection(input, number)
    case input
    when '1'
      HumanPlayer.new(number)
    when '2'
      difficulty_selection_prompt(number)
    else
      retry_input_with_object(method(:player_select_message), method(:player_selection), number)
    end
  end
end
