require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'kerryb/kerryb'
require 'kerryb/possibilities'

describe Kerryb::Kerryb do
  before do
    @game = Kerryb::Kerryb.new
    @game.new_game 7
  end

  describe 'setting the word list' do
    it 'creates a new possibilities set' do
      words = %w(ant bee)
      Kerryb::Possibilities.should_receive(:new).with words
      @game.word_list = words
    end
  end

  describe 'first guess' do
    it 'is the most common letter in the word list' do
      letter = 'x'
      @possibilities.stub(:most_common_letter).and_return letter
      @game.guess('___', 7).should == letter
    end
  end
end
