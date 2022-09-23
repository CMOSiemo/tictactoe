# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Describe behaviour of computer player difficulty: medium
class ComputerMedium < ComputerPlayer
  def turn(score)
    win_or_block(score) || respond_opening(score) || place_random(score)
  end
end
