class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = 10.times.map{ ("A".."Z").to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @grid = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @word_exists = JSON.parse(open(url).read)['found']
    grid_check = []
    unless @word.nil?
      @word.each_char do |char|
       grid_check << @grid.include?(char.upcase)
       grid_check << (@word.count(char.upcase) <= @grid.count(char.upcase))
      end
      @score = 100 * @word.size
    end
    @valid = grid_check.all?
  end

end
