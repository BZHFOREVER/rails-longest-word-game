require "open-uri"

class GamesController < ApplicationController
  def new
    grid = []

    10.times do
      letter = ('A'..'Z').to_a.sample
      grid << letter
    end
    @letters = grid
  end

  def score
    @params = params
  end
  def score
    if included?(params['user-word'].upcase, params[:letters])
      if english_word?(params['user-word'])
        @message = "well done"
      else
        @message = "not an english word"
      end
    else
      @message = "not in the grid"
    end
  end


  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}").open
    json = JSON.parse(response.read)
    return json['found']
  end
end
