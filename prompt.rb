# Copyright (c) 2022 Claudio Martínez Ortiz

# frozen_string_literal: true

# Describes methods that prompt user for input
module Prompt
  def difficulty_selection_prompt(number)
    difficulty_selection_message(number)
    difficulty_selection(gets.chomp, number)
  end

  def last_menu_prompt
    last_menu_message
    last_menu_selection(gets.chomp)
  end

  def player_select_prompt(number)
    clear
    player_select_message(number)
    player_selection(gets.chomp, number)
  end
end
