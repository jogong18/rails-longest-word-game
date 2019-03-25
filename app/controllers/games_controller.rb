require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    a = []
    10.times { a << ('a'..'z').to_a.sample }
    @letters = a
  end

  def score
    # raise
    @word = params[:word]
    @grid = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    word_hash = JSON.parse(user_serialized)

    check_letters = @word.split.all? do |letter|
      @word.split.count(letter) <= @grid.split.count(letter)
    end

    if check_letters == false
      return @result = "Sorry but #{@word} can't be built out of #{@grid}"
    elsif word_hash["found"] != true
      return @result = "Sorry #{@word} doesn't seem to be an English word"
    else
      return @result = "congratulations! #{@word} is a valid English word"
    end
  end
end
