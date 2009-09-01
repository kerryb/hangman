require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/kerryb'
require 'kerryb/possibilities'

describe Kerryb::Kerryb do
  before do
    @possibilities = stub Kerryb::Possibilities, :null_object => true
    Kerryb::Possibilities.stub(:new).and_return @possibilities
    @game = Kerryb::Kerryb.new
    @game.new_game 7
    @words = %w(ant bee)
    @game.word_list = @words
  end

  describe 'starting a new game' do
    it 'creates a new possibilities set' do
      Kerryb::Possibilities.should_receive(:new).with @words
      @game.new_game 7
    end
  end

  describe 'making a guess' do
    it 'updates the possibilities list with the current pattern' do
      pattern = 'f__bar'
      @possibilities.should_receive(:narrow_down).with pattern
      @game.guess pattern, 7
    end

    it 'uses the suggested guess from the word list' do
      @possibilities.stub(:suggest_guess).and_return 'x'
      @game.guess('___', 7).should == 'x'
    end
  end

  describe 'after an incorrect guess' do
    it 'marks the letter as used' do
      @possibilities.should_receive(:letter_used).with 'z'
      @game.incorrect_guess 'z'
    end
  end

  describe 'after a correct guess' do
    it 'marks the letter as used' do
      @possibilities.should_receive(:letter_used).with 'z'
      @game.correct_guess 'z'
    end
  end
end
