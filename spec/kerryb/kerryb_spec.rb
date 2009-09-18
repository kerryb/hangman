require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/kerryb'

describe Kerryb::Kerryb do
  before do
    @game = Kerryb::Kerryb.new
    @game.word_list = %w(ant bee ape asp)
    @game.new_game 7
  end

  describe 'guessing a letter' do
    describe 'when no letters are known' do
      it 'guesses in letter frequency order' do
        %w(e t a o i n s r h l d c u m f p g w y b v k x j q z).each do |letter|
          @game.guess('___', 5).should == letter
          @game.incorrect_guess letter
        end
      end
    end

    describe 'when at least one letter is known' do
      it 'uses the one which appears in the most words' do
        @game.guess('a__', 5).should == 'a'
      end

      it "ignores potential words which don't match" do
        @game.guess('b__', 5).should == 'e'
      end

      it 'ignores letters that have already been correctly guessed' do
        @game.correct_guess 'a'
        @game.guess('a__', 5).should_not == 'a'
      end

      it 'ignores letters that have already been incorrectly guessed' do
        @game.incorrect_guess 'e'
        @game.guess('a__', 5).should_not == 'e'
      end

      describe 'when two letters appear in the same number of words' do
        it 'gives the one that appears the most times' do
          @game.word_list = %w(ant asp ass)
          @game.new_game 7
          @game.correct_guess 'a'
          @game.guess('a__', 5).should == 's'
        end
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
      game.guess('___', 5).should == 't'
      game.correct_guess 't'
      game.guess('__t', 4).should == 'a'
      game.correct_guess 'a'
      game.guess('a_t', 3).should == 'n'
      game.correct_guess 'n'
      game.game_result 'win', 'ant'
    end
  end
end
