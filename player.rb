# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Player object class
class Player
  require_relative 'display'
  include Display
  attr_reader :score

  def initialize(number)
    @number = number
    @mark = pick_mark(number)
    @score = 0
  end

  private

  def check_game_over(mark, score)
    case mark
    when 'X'
      victory_message(score)
    when 'O'
      victory_message(score)
    when 'DRAW'
      draw_message(score)
    end
  end

  def turn(score)
    check_game_over(score.board.check_stalemate, score)
  end

  def pick_mark(number)
    case number
    when 1
      'X'
    when 2
      'O'
    end
  end
end
