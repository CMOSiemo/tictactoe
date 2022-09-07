# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Board object class
class Board
  attr_reader :game_over

  WIN_CONDITIONS = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[1 4 7], %w[2 5 8], %w[3 6 9], %w[1 5 9], %w[7 5 3]].freeze
  def initialize
    @game_over = false
    @positions =
      { '1' => '1', '2' => '2', '3' => '3', '4' => '4', '5' => '5', '6' => '6', '7' => '7', '8' => '8', '9' => '9' }
  end

  def positions_left
    @positions_left = (@positions.select { |_position, mark| /[0-9]/ =~ mark }).values
  end

  def victor(lines)
    case lines
    when 'XXX'
      'X'
    when 'OOO'
      'O'
    end
  end

  def next_move_draws?
    holder = @positions.clone
    holder[@positions_left[0]] = 'X'
    check_victory(holder, false) != 'X'
  end

  def check_victory(positions, game_state)
    WIN_CONDITIONS.each do |line|
      lines = line.reduce('') { |lines_played, position| lines_played + positions[position] }
      if victor(lines)
        game_state = true
        return victor(lines)
      end
    end
  end

  def check_stalemate
    if @positions_left.size == 1 && next_move_draws?
      @positions[@positions_left[0]] = 'X'
      @game_over = true
      return 'DRAW'
    end
    check_victory(@positions, @game_over)
  end

  def mark_placed?(input)
    @positions[input] == input
  end

  def place(input, mark)
    @positions[input] = mark
    positions_left
  end

  private

  def to_s
    " #{@positions['1']} | #{@positions['2']} | #{@positions['3']} " \
    "\n---+---+---\n" \
    " #{@positions['4']} | #{@positions['5']} | #{@positions['6']} " \
    "\n---+---+---\n" \
    " #{@positions['7']} | #{@positions['8']} | #{@positions['9']} "
  end
end
