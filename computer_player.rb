# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Computer Player object class
class ComputerPlayer < Player
  %w[display prompt input_validation].each { |file| require_relative file }
  include Display
  include Prompt
  include InputValidation

  def initialize(number)
    super(number)
    difficulty
  end

  private

  def block(score)
    score.board.place(score.board.next_turn_wins?(@mark, @number), @mark)
  end

  def difficulty
    case self.class.name
    when 'ComputerEasy'
      @difficulty = 'easy'
    when 'ComputerMedium'
      @difficulty = 'medium'
    when 'ComputerHard'
      @difficulty = 'hard'
    end
  end

  def place_random(score)
    score.board.place(score.board.available_positions.values.sample, @mark)
  end

  def respond_opening(score)
    opening_check(score) if score.board.how_many_available_positions == 8
  end

  def opening_check(score)
    case score.board.marked_opening_position
    when 'center'
      score.board.place_corner(@mark)
    when 'corner'
      score.board.place_center(@mark)
    when 'side'
      score.board.respond_side(@mark)
    end
  end

  def win(score)
    score.board.place(score.board.next_turn_wins?(@mark), @mark)
  end

  def win_or_block(score)
    if score.board.next_turn_wins?(@mark)
      win(score)
    elsif score.board.next_turn_wins?(@mark, @number)
      block(score)
    end
  end

  def to_s
    "Player #{@number}: computer, #{@difficulty} difficulty, marks #{@mark}"
  end
end
