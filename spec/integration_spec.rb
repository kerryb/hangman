require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'kerryb/kerryb'

describe 'Playing a game' do
  it 'should all turn out much as expected' do
    game = Kerryb::Kerryb.new
    game.word_list = %w(ant bee ape aardvark)
    game.new_game 5
    game.guess('___', 5).should == 'e'
    game.incorrect_guess 'e'
    game.guess('___', 4).should == 'a'
    game.correct_guess 'a'
    game.guess('a__', 3).should == 'n'
    game.correct_guess 'n'
    game.guess('an_', 2).should == 't'
    game.correct_guess 't'
    game.game_result 'win', 'ant'
  end
end
