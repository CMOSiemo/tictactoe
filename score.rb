# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Game score class
class Score
  %w[display prompt input_validation
     player human_player computer_player computer_easy computer_medium computer_hard
     board].each { |file| require_relative file }
  include Display
  include Prompt
  include InputValidation
  attr_accessor :board, :draws
  attr_reader :players

  def initialize
    initialize_players
    initialize_draws
    new_board
    selected_players_message
  end

  def new_board
    @board = Board.new
    @board.start_game
  end

  private

  def initialize_draws
    @draws = 0
  end

  def initialize_players
    @first_player = player_select_prompt(1)
    @second_player = player_select_prompt(2)
    @players = [@first_player, @second_player]
  end

  def to_s
    "Score:\n\
    Player 1(X) #{@first_player.score} - #{@second_player.score} Player 2(O)\n\
    Draws: #{@draws}"
  end
end
