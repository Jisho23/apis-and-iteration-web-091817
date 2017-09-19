require 'rest-client'
require 'json'
require 'pry'

def ruby_hasher(api_link)
  all_characters = RestClient.get(api_link)
  character_hash = JSON.parse(all_characters)
end

def characterArray(array)
  array.map!{|link| ruby_hasher(link)['name']}
  #return array
end

def show_movie(episode)
  movie_hash = ruby_hasher('https://swapi.co/api/films/')['results']
  movie_hash.each do |movie|
    if episode.upcase == movie['title'].upcase
      return characterArray(movie['characters'])
    end
  end
  puts "Please try a different title"
end

puts "Please input a Star Wars movie name as a string or type exit!"
while

  episode = gets.chomp!
  if episode == "exit"
    exit
  end
  puts show_movie(episode)
  puts "Please input another movie or type exit!"
end


=begin
puts 'Choose episode'
while
  episode = gets.chomp
  if episode.downcase == "exit"
    puts "Goodbye!"
    exit
  end
  show_movie(episode)
end
=end
