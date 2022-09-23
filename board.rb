# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Board object class
class Board
  attr_reader :ongoing_game

  CORNERS = %w[1 3 7 9].freeze
  WIN_CONDITIONS = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[1 4 7], %w[2 5 8], %w[3 6 9], %w[1 5 9], %w[7 5 3]].freeze

  def initialize
    halt_game
    @positions =
      { '1' => '1', '2' => '2', '3' => '3', '4' => '4', '5' => '5', '6' => '6', '7' => '7', '8' => '8', '9' => '9' }
    available_positions
  end

  def available_positions
    @available_positions = @positions.select { |_position, mark| /[0-9]/ =~ mark }
  end

  def check_fork(mark)
    winning_lines = 0
    @available_positions.each_value do |position|
      holder = @positions.clone
      holder[@available_positions[position]] = mark
      winning_lines += 1 if check_victory(holder, false)
    end
    winning_lines
  end

  def check_stalemate
    if @available_positions.size == 1 && next_move_draws?
      @positions[@available_positions.values[0]] = 'X'
      @ongoing_game = false
      return 'DRAW'
    end
    check_victory(@positions, true)
  end

  def check_victory(positions, game_state)
    WIN_CONDITIONS.each do |line|
      lines = line.reduce('') { |lines_played, position| lines_played + positions[position] }
      if victor?(lines)
        @ongoing_game = false if game_state
        return victor?(lines)
      end
    end
    false
  end

  def fork?(mark)
    @available_positions.each_value do |position|
      holder = @positions.clone
      holder[@available_positions[position]] = mark
      return position if check_fork(mark) > 1
    end
  end

  private

  def halt_game
    @ongoing_game = false
  end

  public

  def how_many_available_positions
    @available_positions.size
  end

  def marked_in?(input)
    @positions[input] == input
  end

  def marked_opening_position
    if marked_x[0] == '5'
      'center'
    elsif CORNERS.include?(marked_x[0])
      'corner'
    else
      'side'
    end
  end

  def marked_x
    (@positions.select { |_position, mark| /X/ =~ mark }).keys
  end

  def next_move_draws?
    holder = @positions.clone
    holder[@available_positions.values[0]] = 'X'
    check_victory(holder, false) == false
  end

  def next_turn_wins?(mark, number = nil)
    mark = (number ? opponent_mark(mark) : mark)
    @available_positions.each_value do |position|
      holder = @positions.clone
      holder[@available_positions[position]] = mark
      return position if check_victory(holder, false)
    end
    false
  end

  def opponent_mark(mark)
    case mark
    when 'X'
      'O'
    when 'O'
      'X'
    end
  end

  def place(input, mark)
    @positions[input] = mark
    available_positions
  end

  def place_center(mark)
    place('5', mark)
  end

  def place_corner(mark)
    place(CORNERS.sample, mark)
  end

  def place_fork(mark)
    place(fork_place, mark)
  end

  def respond_side(mark)
    case marked_x[0]
    when '2'
      place(%w[1 3 5 8].sample, mark)
    when '4'
      place(%w[1 5 6 7].sample, mark)
    when '6'
      place(%w[3 4 5 9].sample, mark)
    else
      place(%w[2 5 7 9].sample, mark)
    end
  end

  def start_game
    @ongoing_game = true
  end

  def victor?(lines)
    case lines
    when 'XXX'
      'X'
    when 'OOO'
      'O'
    end
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
