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
          current_movie_json = RestClient.get(api_link)
          current_movie_hash = JSON.parse(current_movie_json)
          hash_character_movies[current_movie_hash["episode_id"]] = current_movie_hash["title"]
        end
        return hash_character_movies
      end
    end
    if character_hash["next"] == nil
      break
    end
    character_hash = ruby_hasher(character_hash["next"])
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def ruby_hasher(api_link)
  all_characters = RestClient.get(api_link)
  character_hash = JSON.parse(all_characters)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.sort_by {|num, name| num}.each do |num, name|
    puts "#{num}. #{name}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)

  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
