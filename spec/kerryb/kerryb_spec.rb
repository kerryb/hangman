require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/kerryb'

describe Kerryb::Kerryb do
  before do
    @game = Kerryb::Kerryb.new
    @game.word_list = %w(ant bee ape man)
    @game.new_game 7
  end

  describe 'suggesting a letter to guess' do
    it 'provides the letter which appears in the most words' do
      @game.guess('___', 5).should == 'a'
    end

    it "ignores potential words which don't match" do
      @game.guess('b__', 5).should == 'e'
    end

    it 'ignores letters that have already been correctly guessed' do
      @game.correct_guess 'a'
      @game.guess('___', 5).should == 'e'
    end

    it 'ignores letters that have already been incorrectly guessed' do
      @game.incorrect_guess 'a'
      @game.guess('___', 5).should == 'e'
    end

    describe 'when two letters appear in the same number of words' do
      it 'provides the one that appears the most times' do
        @game.word_list = %w(ant bee ape)
        @game.new_game 7
        @game.guess('___', 5).should == 'e'
      end
    end
  end

  describe 'Playing a game' do
    it 'all turns out much as expected' do
      game = Kerryb::Kerryb.new
      game.word_list = %w(ant bee ape aardvark)
      game.new_game 5
      game.guess('___', 5).should == 'e'
      game.incorrect_guess 'e'
      game.guess('___', 4).should == 't'
      game.correct_guess 't'
      game.guess('__t', 4).should == 'n'
      game.correct_guess 'n'
      game.guess('_nt', 4).should == 'a'
      game.correct_guess 'a'
      game.game_result 'win', 'ant'
    end
  end
end
