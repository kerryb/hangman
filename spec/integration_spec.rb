require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'kerryb/kerryb'

describe 'Playing a game' do
  it 'should all turn out much as expected' do
    game = Kerryb::Kerryb.new
    game.word_list = %w(ant bee ape aardvark)
    game.new_game 5
    game.guess('___', 5).should == 'a'
    game.incorrect_guess 'a'
    game.guess('___', 4).should == 'e'
    game.correct_guess 'e'
    game.guess('_ee', 3).should == 'b'
    game.correct_guess 'b'
    game.game_result 'win', 'bee'
  end
end
