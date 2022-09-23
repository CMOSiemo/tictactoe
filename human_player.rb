# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Human Player object class
class HumanPlayer < Player
  require_relative 'input_validation'
  include InputValidation

  def turn(score)
    clear
    play_message(score.board)
    play(gets.chomp, score.board)
    super(score)
  end

  private

  def to_s
    "Player #{@number}: human, marks #{@mark}"
  end
end
