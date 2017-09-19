require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  character_hash = ruby_hasher('http://www.swapi.co/api/people/')
  hash_character_movies = {}
  while character_hash
    character_hash["results"].each do |current_character|
      if current_character["name"].downcase == character.downcase
        current_character["films"].each do |api_link|
          current_movie_hash = ruby_hasher(api_link)
          hash_character_movies[current_movie_hash["episode_id"]] = current_movie_hash["title"]
        end
        return hash_character_movies
      end
    end
    if character_hash["next"] == nil
      puts "Please put in a real character."
      return nil
    end
    character_hash = ruby_hasher(character_hash["next"])
  end

end

def ruby_hasher(api_link)
  all_characters = RestClient.get(api_link)
  character_hash = JSON.parse(all_characters)
end

def parse_character_movies(films_hash=nil)
  # some iteration magic and puts out the movies in a nice list
  if films_hash != nil
    films_hash.sort_by {|num, name| num}.each do |num, name|
      puts "#{num}. #{name}"
    end
  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
