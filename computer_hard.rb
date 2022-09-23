# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Describe behaviour of computer player difficulty: hard
class ComputerHard < ComputerPlayer
  def turn(score)
    win_or_block(score) || respond_opening(score) || place_fork(score) || place_random(score)
  end

  def place_fork(score); end
end
