# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Retry pick module for alternative input validation
module RetryPick
  def invalid_input_message
    puts 'Invalid input, please try again'
  end

  def retry_selection(message, method)
    puts "\e[H\e[2J"
    invalid_input_message
    message.call
    method.call(gets.chomp)
  end

  def retry_play(message, method, board)
    puts "\e[H\e[2J"
    invalid_input_message
    message.call(board)
    method.call(gets.chomp, board)
  end
end
