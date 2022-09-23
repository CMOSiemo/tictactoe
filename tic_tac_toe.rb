# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Describes main program behaviour
class TicTacToe
  %w[display prompt input_validation score].each { |file| require_relative file }
  include Display
  include Prompt
  include InputValidation

  def initialize
    new_score
    start_game
  end

  private

  def new_score
    @score = Score.new
  end

  def play_again
    @score.new_board
    start_game
  end

  def start_game
    @score.players.each { |player| player.turn(@score) if @score.board.ongoing_game } while @score.board.ongoing_game
    last_menu_prompt
  end
end

TicTacToe.new
