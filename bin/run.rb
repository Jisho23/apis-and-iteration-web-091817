#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
while
  character = get_character_from_user
  if character.downcase == "exit"
    puts "Goodbye!"
    exit
  end
  show_character_movies(character)
end
